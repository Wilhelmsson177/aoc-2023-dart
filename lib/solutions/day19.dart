import 'package:aoc/index.dart';
import 'package:dartx/dartx.dart';

RegExp machinePartRegExp = RegExp(r"([xmas])=(\d+)");
RegExp workflowConditionRegExp = RegExp(r"([xmas])([><])(\d+):(.+)");
RegExp workflowRegExp = RegExp(r"([a-zA-Z]+)\{(.+)\}");

enum Comperator { greater, less }

class WorkflowCondition {
  late String? identifier;
  late Comperator? comperator;
  late String? next;
  late bool reject = false;
  late bool accept = false;

  WorkflowCondition(String input) {
    if (input == "A") {
      accept = true;
    } else if (input == "R") {
      reject = true;
    } else if (workflowConditionRegExp.hasMatch(input)) {
      var match = workflowConditionRegExp.firstMatch(input)!;
      identifier = match.group(1);
      comperator = switch (match.group(2)) {
        ">" => Comperator.greater,
        "<" => Comperator.less,
        _ => throw Error()
      };
      switch (match.group(3)) {
        case "R":
          reject = true;
          break;
        case "A":
          accept = true;
          break;
        default:
          next = match.group(3);
      }
    } else {
      next = input;
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

    return parts
        .filter((element) => wC.isAccepted(element))
        .fold(0, (previousValue, e) => previousValue + e.x + e.m + e.a + e.s);
  }

  @override
  int solvePartB() {
    // TODO implement
    return 0;
  }
}
