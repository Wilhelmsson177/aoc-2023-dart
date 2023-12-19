import 'package:aoc/index.dart';
import 'package:aoc/general.dart';
import 'package:dartx/dartx.dart';

class DigInstruction {
  late final Direction direction;
  late final int stepSize;

  DigInstruction(String input, bool conversion) {
    if (!conversion) {
      direction = switch (input.split(" ").first) {
        "R" => Direction.east,
        "L" => Direction.west,
        "D" => Direction.south,
        "U" => Direction.north,
        String() => throw Error(),
      };
      stepSize = input.split(" ").second.toInt();
    } else {
      stepSize = int.parse(
          "0x${input.split(" ").last.removeSurrounding(prefix: "(", suffix: ")").substring(1, 6)}");
      direction = switch (input
          .split(" ")
          .last
          .removeSurrounding(prefix: "(", suffix: ")")
          .substring(6)) {
        "0" => Direction.east,
        "1" => Direction.south,
        "2" => Direction.west,
        "3" => Direction.north,
        _ => throw Error()
      };
    }
  }
}

class Day18 extends GenericDay {
  final String inType;
  Day18([this.inType = 'in']) : super(18, inType);

  @override
  Iterable<DigInstruction> parseInput([bool conversion = false]) {
    final lines = input.getPerLine();
    return lines.map((e) => DigInstruction(e, conversion));
  }

  @override
  int solvePartA() {
    final digInstructions = parseInput();
    return lagoonSize(digInstructions);
  }

  int lagoonSize(Iterable<DigInstruction> digInstructions) {
    List<Position> polygon = [];
    polygon.add(Position(0, 0));
    int borderLength = 0;
    for (var element in digInstructions) {
      Position lastPosition = polygon.last;
      polygon.add(switch (element.direction) {
        Direction.south =>
          Position(lastPosition.x, lastPosition.y + element.stepSize),
        Direction.north =>
          Position(lastPosition.x, lastPosition.y - element.stepSize),
        Direction.east =>
          Position(lastPosition.x + element.stepSize, lastPosition.y),
        Direction.west =>
          Position(lastPosition.x - element.stepSize, lastPosition.y),
      });
      borderLength += element.stepSize;
    }
    assert(polygon.first == polygon.last);
    polygon.removeLast();

    var area = calculatePolygonArea(polygon) + borderLength;
    // i = A - b/2 - h + 1
    // h is 0 because no holes expected
    return area.abs() - (borderLength / 2).floor() + 1;
  }

  @override
  int solvePartB() {
    final digInstructions = parseInput(true);
    return lagoonSize(digInstructions);
  }
}
