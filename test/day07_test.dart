import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
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
}
