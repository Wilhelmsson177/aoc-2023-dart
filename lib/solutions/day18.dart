import 'package:aoc/index.dart';
import 'package:aoc/general.dart';
import 'package:aoc/logger.dart';
import 'package:dartx/dartx.dart';

class DigInstruction {
  late final Direction direction;
  late final int stepSize;
  late final String color;

  DigInstruction(String input) {
    direction = switch (input.split(" ").first) {
      "R" => Direction.east,
      "L" => Direction.west,
      "D" => Direction.south,
      "U" => Direction.north,
      String() => throw Error(),
    };
    stepSize = input.split(" ").second.toInt();
    color = input.split(" ").last.removeSurrounding(prefix: "(", suffix: ")");
  }
}

class Day18 extends GenericDay {
  final String inType;
  Day18([this.inType = 'in']) : super(18, inType);

  @override
  Iterable<DigInstruction> parseInput() {
    final lines = input.getPerLine();
    return lines.map((e) => DigInstruction(e));
  }

  @override
  int solvePartA() {
    final digInstructions = parseInput();
    List<Position> positions = [];
    positions.add(Position(0, 0));
    for (var element in digInstructions) {
      Position lastPosition = positions.last;
      for (var i = 1; i <= element.stepSize; i++) {
        positions.add(switch (element.direction) {
          Direction.south => Position(lastPosition.x, lastPosition.y + i),
          Direction.north => Position(lastPosition.x, lastPosition.y - i),
          Direction.east => Position(lastPosition.x + i, lastPosition.y),
          Direction.west => Position(lastPosition.x - i, lastPosition.y),
        });
      }
    }
    int minY = min(positions.map((e) => e.y).toList())!;
    int minX = min(positions.map((e) => e.x).toList())!;

    assert(positions.first == positions.last);
    positions.removeLast();
    positions = positions
        .map((e) => Position(e.x + minX.abs(), e.y + minY.abs()))
        .toList();
    int maxY = max(positions.map((e) => e.y).toList())!;
    int maxX = max(positions.map((e) => e.x).toList())!;
    List<List<String>> rawField = [];
    for (var y = 0; y <= maxY; y++) {
      List<String> rawLine = [];
      List<Position> realBoarder = [];
      for (var x = 0; x <= maxX; x++) {
        bool isRealBoarder = positions.contains(Position(x, y));
        if (isRealBoarder) {
          realBoarder.add(Position(x, y));
          // remove first, if consecutive
          realBoarder.removeWhere((element) => element.x == x - 1);
        }

        rawLine.add(isRealBoarder || (realBoarder.length % 2 == 1) ? "#" : ".");
      }
      rawField.add(rawLine);
    }
    Field field = Field(rawField);
    talker.verbose(field.toString());
    return field.count("#");
  }

  @override
  int solvePartB() {
    // TODO implement
    return 0;
  }
}
