import 'package:aoc/index.dart';
import 'package:aoc/general.dart';

typedef DirectedPosition = ({Direction from, Position position});

class LavaFloor extends Field<String> {
  Set<DirectedPosition> energized = {};

  LavaFloor(super.field);

  @override
  String toString() {
    StringBuffer result = StringBuffer();
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        result.write(energized.map((e) => e.position).contains(Position(x, y))
            ? "#"
            : getValueAt(x, y));
      }
      result.writeln();
    }
    return result.toString();
  }

  void reset() {
    energized.clear();
  }

  Set<Position> get energizedTiles =>
      Set.from(energized.map((e) => e.position));

  void beamUp(DirectedPosition start) {
    if (!energized.contains(start) && isOnField(start.position)) {
      DirectedPosition next = start;
      bool finished = false;
      do {
        energized.add(next);
        switch (getValueAtPosition(next.position)) {
          case ".":
            next = (
              from: next.from,
              position: switch (next.from) {
                Direction.west =>
                  Position(next.position.x + 1, next.position.y),
                Direction.east =>
                  Position(next.position.x - 1, next.position.y),
                Direction.south =>
                  Position(next.position.x, next.position.y - 1),
                Direction.north =>
                  Position(next.position.x, next.position.y + 1),
              }
            );
            break;
          case "/":
            next = (
              from: switch (next.from) {
                Direction.west => Direction.south,
                Direction.east => Direction.north,
                Direction.south => Direction.west,
                Direction.north => Direction.east,
              },
              position: switch (next.from) {
                Direction.west =>
                  Position(next.position.x, next.position.y - 1),
                Direction.east =>
                  Position(next.position.x, next.position.y + 1),
                Direction.south =>
                  Position(next.position.x + 1, next.position.y),
                Direction.north =>
                  Position(next.position.x - 1, next.position.y),
              }
            );
            break;
          case r"\":
            next = (
              from: switch (next.from) {
                Direction.west => Direction.north,
                Direction.east => Direction.south,
                Direction.south => Direction.east,
                Direction.north => Direction.west,
              },
              position: switch (next.from) {
                Direction.west =>
                  Position(next.position.x, next.position.y + 1),
                Direction.east =>
                  Position(next.position.x, next.position.y - 1),
                Direction.south =>
                  Position(next.position.x - 1, next.position.y),
                Direction.north =>
                  Position(next.position.x + 1, next.position.y),
              }
            );
            break;
          case "-":
            switch (next.from) {
              case Direction.west:
                next = (
                  from: next.from,
                  position: Position(next.position.x + 1, next.position.y)
                );
                break;
              case Direction.east:
                next = (
                  from: next.from,
                  position: Position(next.position.x - 1, next.position.y)
                );
                break;
              case Direction.south:
              case Direction.north:
                finished = true;
                beamUp((
                  from: Direction.west,
                  position: Position(next.position.x + 1, next.position.y)
                ));
                beamUp((
                  from: Direction.east,
                  position: Position(next.position.x - 1, next.position.y)
                ));
                break;
            }
            break;
          case "|":
            switch (next.from) {
              case Direction.north:
                next = (
                  from: next.from,
                  position: Position(next.position.x, next.position.y + 1)
                );
                break;
              case Direction.south:
                next = (
                  from: next.from,
                  position: Position(next.position.x, next.position.y - 1)
                );
                break;
              case Direction.east:
              case Direction.west:
                finished = true;
                beamUp((
                  from: Direction.north,
                  position: Position(next.position.x, next.position.y + 1)
                ));
                beamUp((
                  from: Direction.south,
                  position: Position(next.position.x, next.position.y - 1)
                ));
                break;
            }
            break;
          default:
        }
        finished |= !isOnField(next.position);
        finished |= energized.contains(next);
      } while (!finished);
    }
  }
}

class Day16 extends GenericDay {
  final String inType;
  Day16([this.inType = 'in']) : super(16, inType);

  @override
  LavaFloor parseInput() {
    final lines = input.getPerLine();
    return LavaFloor(lines.map((element) => element.split("")).toList());
  }

  @override
  int solvePartA() {
    final lavaFloor = parseInput();
    lavaFloor.beamUp((from: Direction.west, position: Position(0, 0)));
    return lavaFloor.energizedTiles.length;
  }

  @override
  int solvePartB() {
    List<int> energizedTiles = [];
    final lavaFloor = parseInput();
    for (int x in [0, lavaFloor.width]) {
      for (var y = 0; y < lavaFloor.height; y++) {
        lavaFloor.reset();
        lavaFloor.beamUp((
          from: x > 0 ? Direction.east : Direction.west,
          position: Position(x, y)
        ));
        energizedTiles.add(lavaFloor.energizedTiles.length);
      }
    }
    for (int y in [0, lavaFloor.height]) {
      for (var x = 0; x < lavaFloor.width; x++) {
        lavaFloor.reset();
        lavaFloor.beamUp((
          from: y > 0 ? Direction.south : Direction.north,
          position: Position(x, y)
        ));
        energizedTiles.add(lavaFloor.energizedTiles.length);
      }
    }
    return max(energizedTiles)!;
  }
}
