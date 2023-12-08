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
    expect(day.solvePartB(), 0);
  });

  test('Day08 - simple', () async {
    String input = """LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)""";
    int expectation = 6;
    var day = Day08(input);
    expect(day.solvePartA(), expectation);
    expect(day.solvePartB(), 0);
  });
}
