import 'package:aoc/index.dart';

class Day21 extends GenericDay {
  final String inType;
  Day21([this.inType = 'in']) : super(21, inType);

  @override
  Field<String> parseInput() {
    final lines = input.getPerLine();
    return Field(lines.map((element) => element.split("")).toList());
  }

  @override
  int solvePartA({int iterations = 64}) {
    final field = parseInput();
    Set<Position> positions = {};
    field.forEach((p0, p1) {
      if (field.getValueAt(p0, p1) == "S") {
        positions.add(Position(p0, p1));
      }
    });
    for (var i = 0; i < iterations; i++) {
      Set<Position> newPositions = {};
      for (var pos in positions) {
        for (var neighbour in field.adjacent(pos.x, pos.y)) {
          if (field.getValueAtPosition(neighbour) != "#") {
            newPositions.add(neighbour);
          }
        }
      }
      positions = newPositions;
    }
    return positions.length;
  }

  @override
  int solvePartB() {
    // TODO implement
    return 0;
  }
}
