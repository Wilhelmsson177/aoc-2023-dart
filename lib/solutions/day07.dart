import 'package:aoc/index.dart';
import 'package:dartx/dartx.dart' hide IterableSorted;

enum HandType {
  street,
  fiveOfAKind,
  fourOfAKind,
  fullHouse,
  threeOfAKind,
  twoPair,
  onePair,
  highCard
}

List<String> cardOrder = [
  "A",
  "K",
  "Q",
  "J",
  "T",
  "9",
  "8",
  "7",
  "6",
  "5",
  "4",
  "3",
  "2"
].reversed.toList();

List<String> cardOrderWithJokers = [
  "A",
  "K",
  "Q",
  "T",
  "9",
  "8",
  "7",
  "6",
  "5",
  "4",
  "3",
  "2",
  "J",
].reversed.toList();

bool isSortedSequence(List<int> list) {
  for (int i = 1; i < list.length; i++) {
    if (list[i] < list[i - 1]) {
      return false;
    }
  }
  return true;
}

Map<int, int> getCountMap(List<int> input) {
  Map<int, int> countMap = {};

  for (int item in input) {
    countMap.putIfAbsent(item, () => 0);
    countMap[item] = countMap[item]! + 1;
  }
  return countMap;
}

class Hand {
  late final HandType ht;
  final int bid;
  late final int highCard;
  late final int firstCard;
  late final String hand;
  late final List<int> orders;
  final bool useJokers;

  Hand(this.hand, this.bid, {this.useJokers = false}) {
    ht = _determineHand();
  }

  HandType _determineHand() {
    if (useJokers) {
      orders =
          hand.split("").map((e) => cardOrderWithJokers.indexOf(e)).toList();
    } else {
      orders = hand.split("").map((e) => cardOrder.indexOf(e)).toList();
    }
    firstCard = orders.first;
    Map<int, int> counts = getCountMap(orders);
    highCard = counts.keys.sorted((a, b) => a.compareTo(b)).last;
    if (useJokers) {
      _applyJokers(counts);
    }
    if (counts.values.contains(5)) {
      return HandType.fiveOfAKind;
    }
    if (counts.values.contains(4)) {
      return HandType.fourOfAKind;
    }
    if (counts.values.contains(3) && counts.values.contains(2)) {
      return HandType.fullHouse;
    }
    if (counts.values.contains(3)) {
      return HandType.threeOfAKind;
    }
    if (counts.values.contains(2) && counts.keys.length == 3) {
      return HandType.twoPair;
    }
    if (counts.values.contains(2)) {
      return HandType.onePair;
    }
    return HandType.highCard;
  }

  int compareTo(Hand other) {
    if (ht == other.ht) {
      for (var i = 0; i < orders.length; i++) {
        if (orders[i] == other.orders[i]) {
          continue;
        }
        return other.orders[i].compareTo(orders[i]);
      }
      throw Error();
    } else {
      return ht.index.compareTo(other.ht.index);
    }
  }

  void _applyJokers(Map<int, int> counts) {
    switch (counts[0]) {
      case 4:
        counts[cardOrder.length] = 4;
        break;
      case 3:
        counts[highCard] = 4;
        break;
      case 2:
        // check for the higher three or the higher pair
        if (counts[highCard]! > 1) {
          counts[highCard] = 4;
        } else {
          MapEntry<int, int> me = counts
              .mapEntries((p0) => p0)
              .sorted((a, b) => b.key.compareTo(a.key))
              .firstWhere((element) => element.value > 1);
          counts[me.key] = 4;
        }
        break;
      case 1:
        MapEntry<int, int> me = counts
            .mapEntries((p0) => p0)
            .sorted((a, b) => b.value.compareTo(a.value))
            .takeWhile((value) => value.value == max(counts.values))
            .sorted((a, b) => b.key.compareTo(a.key))
            .first;
        counts[me.key] = counts[me.key]! + 1;
        break;
      case _:
        break;
    }
  }
}

class Day07 extends GenericDay {
  final String inType;
  Day07([this.inType = 'in']) : super(7, inType);

  @override
  Iterable<Hand> parseInput({bool useJokers = false}) {
    final lines = input.getPerLine();
    return lines.map((e) {
      var splits = e.split(" ");
      Hand hand = Hand(splits.first, splits.last.toInt(), useJokers: useJokers);
      return hand;
    });
  }

  @override
  int solvePartA() {
    final Iterable<Hand> input = parseInput();
    return input.sorted((a, b) => b.compareTo(a)).foldIndexed(0,
        (index, previous, element) => previous + ((index + 1) * element.bid));
  }

  @override
  int solvePartB() {
    final Iterable<Hand> input = parseInput(useJokers: true);
    return input.sorted((a, b) => b.compareTo(a)).foldIndexed(0,
        (index, previous, element) => previous + ((index + 1) * element.bid));
  }
}
