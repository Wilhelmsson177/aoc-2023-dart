import 'package:aoc/logger.dart';
import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

String example = """R 6 (#70c710)
D 5 (#0dc571)
L 2 (#5713f0)
D 2 (#d2c081)
R 2 (#59c680)
D 2 (#411b91)
L 5 (#8ceee2)
U 2 (#caa173)
L 1 (#1b58a2)
U 2 (#caa171)
R 2 (#7807d2)
U 3 (#a77fa3)
L 2 (#015232)
U 2 (#7a21e3)""";
void main() {
  initializeLogging("verbose");
  test('Day18 - Part A', () async {
    int expectation = 62;
    var day = Day18(example);
    expect(day.solvePartA(), expectation);
  });

  test('Day18 - Part B', () async {
    var day = Day18(example);
    int expectation = 952408144115;
    expect(day.solvePartB(), expectation);
  });
}
