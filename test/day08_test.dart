import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  test('Day08', () async {
    String input = """RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)""";
    int expectation = 2;
    var day = Day08(input);
    expect(day.solvePartA(), expectation);
  });

  test('Day08 - simple', () async {
    String input = """LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)""";
    int expectation = 6;
    var day = Day08(input);
    expect(day.solvePartA(), expectation);
  });

  test('Day08 - PArt2', () async {
    String input = """LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)""";
    int expectation = 6;
    var day = Day08(input);
    expect(day.solvePartB(), expectation);
  });
}
