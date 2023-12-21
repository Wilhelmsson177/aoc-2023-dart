import 'package:aoc/index.dart';
import 'package:aoc/logger.dart';
import 'package:dart_eval/dart_eval.dart';
import 'package:dartx/dartx.dart';

RegExp machinePartRegExp = RegExp(r"([xmas])=(\d+)");
RegExp workflowConditionRegExp = RegExp(r"([xmas])([><])(\d+):(.+)");
RegExp workflowRegExp = RegExp(r"([a-zA-Z]+)\{(.+)\}");

enum Comperator {
  greater,
  less;

  String get value {
    return switch (this) {
      Comperator.greater => ">",
      Comperator.less => "<",
    };
  }
}

enum CheckResult { accepted, rejected, jumpNext, stay }

class WorkflowCondition {
  late String? identifier;
  late Comperator? comperator;
  late int? value;
  late final bool needsCompare;
  late CheckResult result;
  String? next;

  WorkflowCondition(String input) {
    if (input == "A") {
      result = CheckResult.accepted;
      needsCompare = false;
    } else if (input == "R") {
      result = CheckResult.rejected;
      needsCompare = false;
    } else if (workflowConditionRegExp.hasMatch(input)) {
      needsCompare = true;
      var match = workflowConditionRegExp.firstMatch(input)!;
      identifier = match.group(1);
      comperator = switch (match.group(2)) {
        ">" => Comperator.greater,
        "<" => Comperator.less,
        _ => throw Error()
      };
      value = int.parse(match.group(3)!);
      switch (match.group(4)) {
        case "R":
          result = CheckResult.rejected;
          break;
        case "A":
          result = CheckResult.accepted;
          break;
        default:
          next = match.group(4);
          result = CheckResult.jumpNext;
      }
    } else {
      next = input;
      needsCompare = false;
      result = CheckResult.jumpNext;
    }
  }

  void checkPart(MachinePart part) {
    if (needsCompare) {
      String expression = switch (identifier) {
        "x" => "${part.x} ${comperator!.value} $value",
        "m" => "${part.m} ${comperator!.value} $value",
        "a" => "${part.a} ${comperator!.value} $value",
        "s" => "${part.s} ${comperator!.value} $value",
        _ => throw Error()
      };
      bool intermediateResult = eval(expression);
      if (!intermediateResult) {
        result = CheckResult.stay;
      }
    }
  }
}

class Workflow {
  late final String name;
  List<WorkflowCondition> workflows = [];
  Workflow(String input) {
    var match = workflowRegExp.firstMatch(input)!;
    name = match.group(1)!;
    workflows
        .addAll(match.group(2)!.split(",").map((e) => WorkflowCondition(e)));
  }
  ({CheckResult result, String? next}) checkPart(MachinePart part) {
    for (WorkflowCondition w in workflows) {
      w.checkPart(part);
      if (w.result == CheckResult.stay) {
        continue;
      }
      return (result: w.result, next: w.next);
    }
    throw Error();
  }
}

class WorkflowCoordinator {
  Map<String, Workflow> workflows = {};

  WorkflowCoordinator(String input) {
    workflows.addEntries(input
        .split("\n")
        .map((e) => Workflow(e))
        .map((e) => MapEntry(e.name, e)));
  }

  bool isAccepted(MachinePart part) {
    String next = "in";
    do {
      var result = workflows[next]!.checkPart(part);
      switch (result.result) {
        case CheckResult.accepted:
          return true;
        case CheckResult.rejected:
          return false;
        case CheckResult.jumpNext:
          next = result.next!;
        case CheckResult.stay:
          continue;
        default:
          throw Error();
      }
    } while (next != "");
    return false;
  }
}

class MachineParts extends DelegatingList<MachinePart> {
  MachineParts(super.base);
}

class MachinePart {
  late final int x;
  late final int m;
  late final int a;
  late final int s;
  MachinePart(String input) {
    machinePartRegExp.allMatches(input).forEach((match) {
      switch (match.group(1)) {
        case "x":
          x = int.parse(match.group(2)!);
          break;
        case "m":
          m = int.parse(match.group(2)!);
          break;
        case "a":
          a = int.parse(match.group(2)!);
          break;
        case "s":
          s = int.parse(match.group(2)!);
          break;
        default:
      }
    });
  }
  @override
  String toString() {
    return "{x=$x,m=$m,a=$a,s=$s}";
  }
}

class Day19 extends GenericDay {
  final String inType;
  Day19([this.inType = 'in']) : super(19, inType);

  @override
  ({MachineParts parts, WorkflowCoordinator workflowCoordinator}) parseInput() {
    final blocks = input.getBy("\n\n").map((e) => e.trim());
    WorkflowCoordinator wC = WorkflowCoordinator(blocks.first);
    MachineParts parts = MachineParts(
        blocks.last.split("\n").map((e) => MachinePart(e)).toList());

    return (parts: parts, workflowCoordinator: wC);
  }

  @override
  int solvePartA() {
    var input = parseInput();
    MachineParts parts = input.parts;
    WorkflowCoordinator wC = input.workflowCoordinator;
    var results = parts.map((p0) => (p0, wC.isAccepted(p0)));
    talker.verbose(results.toList());
    return results.filter((element) => element.$2).fold(
        0,
        (previousValue, e) =>
            previousValue + e.$1.x + e.$1.m + e.$1.a + e.$1.s);
  }

  @override
  int solvePartB() {
    // TODO implement
    return 0;
  }
}
