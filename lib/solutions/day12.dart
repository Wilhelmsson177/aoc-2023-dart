import 'package:aoc/index.dart';
import 'package:aoc/logger.dart';
import 'package:dartx/dartx.dart' hide IterableMapIndexed;
import "package:trotter/trotter.dart";

final bagOfItems = characters(".#");

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
    RegExp questionMarks = RegExp(r"\?");
    final permutations = Amalgams(
        questionMarks.allMatches(unconditionalSprings).length, bagOfItems);
    int sum = 0;
    for (var permutation in permutations()) {
      final newTry = unconditionalSprings.replaceAllMapped(
          questionMarks, (match) => permutation.removeAt(0));
      var matches = toCheck.allMatches(newTry);
      if (matches.length == expectation.length &&
          matches.mapIndexed((index, element) => (index, element)).all(
              (element) => element.$2[0]!.length == expectation[element.$1])) {
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
