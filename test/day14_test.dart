import 'package:aoc/logger.dart';
import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  initializeLogging("verbose");
  test('Day14', () async {
    String input = """O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....""";
    int expectation = 136;
    var day = Day14(input);
    expect(day.solvePartA(), expectation);
  });

  test('Day14 - Part B', () async {
    String input = """O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....""";
    int expectation = 0;
    var day = Day14(input);
    expect(day.solvePartB(), expectation);
  });
}
