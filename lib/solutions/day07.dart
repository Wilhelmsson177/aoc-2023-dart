import 'package:aoc/index.dart';
import 'package:aoc/logger.dart';
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

Map<String, int> cardOrder = {
  "A": 14,
  "K": 13,
  "Q": 12,
  "X": 11,
  "T": 10,
  "9": 9,
  "8": 8,
  "7": 7,
  "6": 6,
  "5": 5,
  "4": 4,
  "3": 3,
  "2": 2,
  "J": 1
};

bool isSortedSequence(List<int> list) {
  for (int i = 1; i < list.length; i++) {
    if (list[i] < list[i - 1]) {
      return false;
    }
  }
  return true;
}

class Hand {
  late final HandType ht;
  final int bid;
  late final int highCard;
  late final int firstCard;
  late final String sourceHand;
  String hand = "";
  final bool useJokers;

  Hand(String input, this.bid, {this.useJokers = false}) {
    if (useJokers) {
      hand = input;
    } else {
      hand = input.replaceAll("J", "X");
    }
    sourceHand = hand;
    ht = _determineHand();
  }

  Map<String, int> getCountMap() {
    Map<String, int> countMap = {};

    for (String item in hand.split("")) {
      countMap.putIfAbsent(item, () => 0);
      countMap[item] = countMap[item]! + 1;
    }
    return countMap;
  }

  get value => ht.index;

  HandType _determineHand() {
    Map<String, int> counts = getCountMap();

    List<MapEntry<String, int>> sortedCounts = counts.entries.toList();
    sortedCounts.sort((a, b) {
      if (a.value == b.value) {
        return a.key.compareTo(b.key);
      } else {
        return b.value.compareTo(a.value);
      }
    });
    MapEntry<String, int> mostCommonCard = sortedCounts.first;
    if (mostCommonCard.value == 5) {
      return HandType.fiveOfAKind;
    }

    if (useJokers) {
      MapEntry<String, int> secondCommonCard = sortedCounts.second;
      if (mostCommonCard.key == "J") {
        // measn Joker is mst common
        mostCommonCard = secondCommonCard;
      }
      // convert all J to best card
      hand = hand.replaceAll("J", mostCommonCard.key);
      counts = getCountMap();
      sortedCounts = counts.entries.toList();
      sortedCounts.sort((a, b) {
        if (a.value == b.value) {
          return a.key.compareTo(b.key);
        } else {
          return b.value.compareTo(a.value);
        }
      });
      mostCommonCard = sortedCounts.first;
      if (mostCommonCard.value == 5) {
        return HandType.fiveOfAKind;
      }
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
    if (value != other.value) {
      return value.compareTo(other.value);
    }
    if (ht == other.ht) {
      for (var pair
          in zip([sourceHand.split(""), other.sourceHand.split("")])) {
        if (pair.first == pair.last) {
          continue;
        }
        return cardOrder[pair.last]!.compareTo(cardOrder[pair.first]!);
      }
      return 0;
    }
    throw Error();
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
    talker.debug(input
        .sorted((a, b) => b.compareTo(a))
        .map((e) => e.sourceHand)
        .toList());
    return input.sorted((a, b) => b.compareTo(a)).foldIndexed(0,
        (index, previous, element) => previous + ((index + 1) * element.bid));
  }

  @override
  int solvePartB() {
    final Iterable<Hand> input = parseInput(useJokers: true);
    talker.debug(input
        .sorted((a, b) => b.compareTo(a))
        .map((e) => e.sourceHand)
        .toList());
    talker.debug(
        input.sorted((a, b) => b.compareTo(a)).map((e) => e.ht).toList());
    return input.sorted((a, b) => b.compareTo(a)).foldIndexed(0,
        (index, previous, element) => previous + ((index + 1) * element.bid));
  }
}
