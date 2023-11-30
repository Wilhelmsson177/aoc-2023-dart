import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  test('Day00', () async {
    var day = Day00("example");
    expect(day.solvePartA(), 0);
    expect(day.solvePartB(), 0);
  });
}
