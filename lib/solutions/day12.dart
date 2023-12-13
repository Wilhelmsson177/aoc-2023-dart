import 'package:aoc/index.dart';
import 'package:aoc/logger.dart';
import 'package:dartx/dartx.dart';

List<List<int>> combinations(int n) {
  if (n == 0) {
    return [[]];
  }

  List<List<int>> combinations = [];
  // use https://pub.dev/packages/trotter
  return combinations;
}

class ConditionalSpring {
  late final String unconditionalSprings;
  late final List<int> expectation;

  ConditionalSpring(String input) {
    var splits = input.split(" ");
    unconditionalSprings = splits.first;
    expectation = splits.last.split(",").map((e) => e.toInt()).toList();
  }

  int getArrangements() {
    RegExp toCheck = RegExp("#+");
    int sum = 0;
    for (var (index, match)
        in toCheck.allMatches(unconditionalSprings).indexed) {
      if (match[0]!.length == expectation[index]) {
        sum++;
      }
    }
    talker.verbose(
        "For line $unconditionalSprings I have found $sum correct solution.");
    return sum;
  }
}

class Day12 extends GenericDay {
  final String inType;
  Day12([this.inType = 'in']) : super(12, inType);

  @override
  Iterable<ConditionalSpring> parseInput() {
    final lines = input.getPerLine();
    return lines.map((e) => ConditionalSpring(e));
  }

  @override
  int solvePartA() {
    final input = parseInput();
    return input.fold(0,
        (previousValue, element) => previousValue + element.getArrangements());
  }

  @override
  int solvePartB() {
    // TODO implement
    return 0;
  }
}
