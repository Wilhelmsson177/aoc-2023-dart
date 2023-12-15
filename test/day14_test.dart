import 'package:aoc/input.dart';
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

  test('Day14 - Get Part B weights', () async {
    List<String> inputs = [
      """.....#....
....#...O#
...OO##...
.OO#......
.....OOO#.
.O#...O#.#
....O#....
......OOOO
#...O###..
#..OO#....""",
      """.....#....
....#...O#
.....##...
..O#......
.....OOO#.
.O#...O#.#
....O#...O
.......OOO
#..OO###..
#.OOO#...O""",
      """.....#....
....#...O#
.....##...
..O#......
.....OOO#.
.O#...O#.#
....O#...O
.......OOO
#...O###.O
#.OOO#...O"""
    ];
    for (var element in inputs) {
      talker.info(Dish(InputUtil(11, element)
              .getPerLine()
              .map((e) => e.split(""))
              .toList())
          .currentWeight);
    }
  });
}
