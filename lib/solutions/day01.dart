import 'package:aoc/index.dart';
import 'package:quiver/pattern.dart';

int getValueByString(String input) {
  return switch (input) {
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9,
    _ => int.parse(input)
  };
}

class Day01 extends GenericDay {
  final String inType;
  Day01([this.inType = 'in']) : super(1, inType);

  @override
  List<String> parseInput() {
    final lines = input.getPerLine();
    // exemplary usage of ParseUtil class
    return lines;
  }

  @override
  int solvePartA() {
    final input = parseInput();
    int sum = 0;
    RegExp exp = RegExp(r'\d');
    for (String line in input) {
      var matches = exp.allMatches(line);
      sum += int.parse("${matches.first[0]!}${matches.last[0]!}");
    }
    return sum;
  }

  @override
  int solvePartB() {
    final input = parseInput();
    int sum = 0;
    List<RegExp> exps = [
      RegExp(r'\d'),
      RegExp(r"one"),
      RegExp(r"two"),
      RegExp(r"three"),
      RegExp(r"four"),
      RegExp(r"five"),
      RegExp(r"six"),
      RegExp(r"seven"),
      RegExp(r"eight"),
      RegExp(r"nine")
    ];
    Pattern pattern = matchAny(exps);
    for (String line in input) {
      var matches = pattern.allMatches(line);
      var sorted = matches.sortedByCompare(
          (element) => element.start, (a, b) => a.compareTo(b));
      var matchFirst = sorted.first;
      var matchLast = sorted.last;
      int firstValue = getValueByString(matchFirst[0]!);
      int lastValue = getValueByString(matchLast[0]!);
      sum += int.parse("$firstValue$lastValue");
    }
    return sum;
  }
}
