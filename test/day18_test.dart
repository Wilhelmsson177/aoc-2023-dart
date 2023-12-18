import 'package:aoc/logger.dart';
import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  initializeLogging("verbose");
  test('Day18 - Part A', () async {
    String input = """0""";
    int expectation = 0;
    var day = Day18(input);
    expect(day.solvePartA(), expectation);
  });

  test('Day18 - Part B', () async {
    String input = """0""";
    int expectation = 0;
    var day = Day18(input);
    expect(day.solvePartB(), expectation);
  });
}
