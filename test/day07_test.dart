import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';
import 'package:aoc/logger.dart';

void main() {
  initializeLogging("debug");
  test('Day07', () async {
    String input = """32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483""";
    int expectation = 6440;
    var day = Day07(input);
    expect(day.solvePartA(), expectation);
    expect(day.solvePartB(), 5905);
  });

/*
2345A 1
J345A 2
2345J 3
32T3K 5
KK677 7
T3Q33 11
Q2KJJ 13
T3T3J 17
Q2Q2Q 19
2AAAA 23
T55J5 29
QQQJA 31
KTJJT 34
JJJJJ 37
JJJJ2 41
JAAAA 43
2JJJJ 53
AAAAJ 59
AAAAA 61*/

  test('Day07 - edge cases', () async {
    String input = """2345A 1
Q2KJJ 13
Q2Q2Q 19
T3T3J 17
T3Q33 11
2345J 3
J345A 2
32T3K 5
T55J5 29
KK677 7
KTJJT 34
QQQJA 31
JJJJJ 37
JAAAA 43
AAAAJ 59
AAAAA 61
2AAAA 23
2JJJJ 53
JJJJ2 41""";
    int expectation = 6592;
    var day = Day07(input);
    expect(day.solvePartA(), expectation);
    expect(day.solvePartB(), 6839);
  });
}
