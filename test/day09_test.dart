import 'package:aoc/logger.dart';
import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  initializeLogging("debug");
  test('Day09', () async {
    String input = """0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45""";
    int expectation = 114;
    var day = Day09(input);
    expect(day.solvePartA(), expectation);
    expect(day.solvePartB(), 2);
  });
  test('Day09 - negative example', () async {
    String input =
        """1 -1 -3 -5 -7 -9 -11 -13 -15 -17 -19 -21 -23 -25 -27 -29 -31 -33 -35 -37 -39""";
    int expectation = -41;
    var day = Day09(input);
    expect(day.solvePartA(), expectation);
    expect(day.solvePartB(), 3);
  });
}
