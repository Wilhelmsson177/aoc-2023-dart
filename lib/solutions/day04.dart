import 'package:aoc/index.dart';
import 'package:dartx/dartx.dart';

class Card {
  late Iterable<int> winningNumbers;
  late Iterable<int> ownNumbers;

  Card(String input) {
    List<String> numbers = input.split(":").last.split("|");
    winningNumbers = numbers[0]
        .trim()
        .split(" ")
        .filter((element) => element.isNotBlank)
        .map((e) => e.trim().toInt());
    ownNumbers = numbers[1]
        .trim()
        .split(" ")
        .filter((element) => element.isNotBlank)
        .map((e) => e.trim().toInt());
  }

  int get winningPoint {
    return winningNumbers.intersect(ownNumbers).fold(0,
        (previousValue, element) => previousValue == 0 ? 1 : previousValue * 2);
  }

  int get matchingNumbers {
    return winningNumbers.intersect(ownNumbers).length;
  }
}

class Day04 extends GenericDay {
  final String inType;
  Day04([this.inType = 'in']) : super(4, inType);

  @override
  Iterable<Card> parseInput() {
    final lines = input.getPerLine();
    return lines.map((e) => Card(e));
  }

  @override
  int solvePartA() {
    return parseInput().fold(
        0, (previousValue, element) => previousValue + element.winningPoint);
  }

  @override
  int solvePartB() {
    Iterable<Card> cards = parseInput();
    Map<int, int> cardCounter = Map.fromIterable(
        Iterable.generate(cards.length, (i) => i),
        value: (element) => 1);
    cards.toList().forEachIndexed((index, element) {
      for (var i = 0; i < element.matchingNumbers; i++) {
        cardCounter[index + 1 + i] =
            cardCounter[index + 1 + i]! + cardCounter[index]!;
      }
    });

    return cardCounter.values
        .fold(0, (previousValue, element) => previousValue + element);
  }
}
