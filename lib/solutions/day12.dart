import 'package:aoc/index.dart';

class Day12 extends GenericDay {
  final String inType;
  Day12([this.inType='in']) : super(12, inType);

  @override
  List<int> parseInput() {
    final lines = input.getPerLine();
    // exemplary usage of ParseUtil class
    return ParseUtil.stringListToIntList(lines);
  }

  @override
  int solvePartA() {
    final input = parseInput();
    return 0;
  }

  @override
  int solvePartB() {
    // TODO implement
    return 0;
  }
}

