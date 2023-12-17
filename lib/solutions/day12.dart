import 'package:aoc/index.dart';
import 'package:dartx/dartx.dart';

class Springs {
  late Iterable springs;
  late Iterable configuration;

  Springs(String input) {
    var splits = input.split(" ");
    springs = splits.first.split("");
    configuration = splits.last.split(",").map((e) => e.toInt());
  }

  int validPermutations() {
    var springPermutations = [(group: 0, amount: 0, permutations: 1)];
    final springPermutationCounts = {(group: 0, amount: 0): 1};
    int springsChecked = 0;
    for (final spring in springs) {
      if (spring != '?') {}
    }
    return 0;
  }
}

class Day12 extends GenericDay {
  final String inType;
  Day12([this.inType = 'in']) : super(12, inType);

  @override
  Iterable<Springs> parseInput() {
    final lines = input.getPerLine();
    return lines.map((e) => Springs(e));
  }

  @override
  int solvePartA() {
    final input = parseInput();
    return input.fold(
        0,
        (previousValue, element) =>
            previousValue + element.validPermutations());
  }

  @override
  int solvePartB() {
    // TODO implement
    return 0;
  }
}
