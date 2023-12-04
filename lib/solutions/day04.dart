import 'package:aoc/index.dart';
import 'package:dartx/dartx.dart';

class Card {
  late List<int> winningNumbers;
  late List<int> ownNumbers;

  // Card(this.winningNumbers, this.ownNumbers);
  Card(String input) {
    List<String> numbers = input.split(":").last.split("|");
    winningNumbers = numbers[0]
        .trim()
        .split(" ")
        .filter((element) => element.isNotBlank)
        .map((e) => e.trim().toInt())
        .toList();
    ownNumbers = numbers[1]
        .trim()
        .split(" ")
        .filter((element) => element.isNotBlank)
        .map((e) => e.trim().toInt())
        .toList();
  }

  int get winningPoint {
    return winningNumbers.intersect(ownNumbers).fold(0,
        (previousValue, element) {
      if (previousValue == 0) {
        return 1;
      } else {
        return previousValue * 2;
      }
    });
  }
}

class Day04 extends GenericDay {
  final String inType;
  Day04([this.inType = 'in']) : super(4, inType);

  @override
  List<Card> parseInput() {
    final lines = input.getPerLine();
    return lines.map((e) => Card(e)).toList();
  }

  @override
  int solvePartA() {
    return parseInput().fold(
        0, (previousValue, element) => previousValue + element.winningPoint);
  }

  @override
  int solvePartB() {
    // TODO implement
    return 0;
  }
}
