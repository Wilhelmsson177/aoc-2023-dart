import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  test('Day00', () async {
    String input = "0";
    int expectation = 0;
    var day = Day00(input);
    expect(day.solvePartA(), expectation);
    expect(day.solvePartB(), 0);
  });
}
