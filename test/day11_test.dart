import 'package:aoc/logger.dart';
import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  initializeLogging("verbose");
  test('Day11', () async {
    String input = """...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....""";
    int expectation = 374;
    var day = Day11(input);
    expect(day.solvePartA(), expectation);
    expect(day.solvePartB(), 0);
  });
}
