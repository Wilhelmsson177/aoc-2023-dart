import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  test('Day10', () async {
    String input = """.....
.S-7.
.|.|.
.L-J.
.....""";
    int expectation = 4;
    var day = Day10(input);
    expect(day.solvePartA(), expectation);
  });

  test('Day10 - simple', () async {
    String input = """-L|F7
7S-7|
L|7||
-L-J|
L|-JF""";
    int expectation = 4;
    var day = Day10(input);
    expect(day.solvePartA(), expectation);
  });

  test('Day10 - complex', () async {
    String input = """7-F7-
.FJ|7
SJLL7
|F--J
LJ.LJ""";
    int expectation = 8;
    var day = Day10(input);
    expect(day.solvePartA(), expectation);
  });

  test('Day10 - Part B', () async {
    String input = """...........
.S-------7.
.|F-----7|.
.||.....||.
.||.....||.
.|L-7.F-J|.
.|..|.|..|.
.L--J.L--J.
...........""";
    int expectation = 4;
    var day = Day10(input);
    expect(day.solvePartB(), expectation);
  });
}
