import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  test('Day06', () async {
    String input = """Time:      7  15   30
Distance:  9  40  200""";
    int expectation = 288;
    var day = Day06(input);
    expect(day.solvePartA(), expectation);
    expect(day.solvePartB(), 71503);
  });
}
