import 'package:aoc/logger.dart';
import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  initializeLogging("verbose");
  test('Day16 - Part A', () async {
    String input = r""".|...\....
|.-.\.....
.....|-...
........|.
..........
.........\
..../.\\..
.-.-/..|..
.|....-|.\
..//.|....""";
    int expectation = 46;
    var day = Day16(input);
    expect(day.solvePartA(), expectation);
  });

  test('Day16 - Part B', () async {
    String input = r""".|...\....
|.-.\.....
.....|-...
........|.
..........
.........\
..../.\\..
.-.-/..|..
.|....-|.\
..//.|....""";
    int expectation = 51;
    var day = Day16(input);
    expect(day.solvePartB(), expectation);
  });
}
