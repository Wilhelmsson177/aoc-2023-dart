import 'package:aoc/logger.dart';
import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  initializeLogging("verbose");
  test('Day13', () async {
    String input =
        """#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#
""";
    int expectation = 405;
    var day = Day13(input);
    expect(day.solvePartA(), expectation);
  });

  test('Day13 - Part B', () async {
    String input =
        """#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#
""";
    int expectation = 400;
    var day = Day13(input);
    expect(day.solvePartB(), expectation);
  });
}
