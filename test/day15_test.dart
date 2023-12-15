import 'package:aoc/logger.dart';
import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  initializeLogging("verbose");
  test('Day15 - Part A', () async {
    String input = """rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7""";
    int expectation = 1320;
    var day = Day15(input);
    expect(day.solvePartA(), expectation);
  });

  test('Day15 - Part B', () async {
    String input = """rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7""";
    int expectation = 145;
    var day = Day15(input);
    expect(day.solvePartB(), expectation);
  });
}
