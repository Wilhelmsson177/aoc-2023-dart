import 'package:aoc/logger.dart';
import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  initializeLogging("verbose");
  test('Day21 - Part A', () async {
    String input = """...........
.....###.#.
.###.##..#.
..#.#...#..
....#.#....
.##..S####.
.##..#...#.
.......##..
.##.#.####.
.##..##.##.
...........""";
    int expectation = 16;
    var day = Day21(input);
    expect(day.solvePartA(iterations: 6), expectation);
  });

  test('Day21 - Part B', () async {
    String input = """0""";
    int expectation = 0;
    var day = Day21(input);
    expect(day.solvePartB(), expectation);
  });
}
