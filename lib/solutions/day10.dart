import 'package:aoc/index.dart';
import 'package:dartx/dartx.dart';

class PipeMap extends Field {
  late final Position start;
  final Map<Position, Iterable<Position>> _connectedPipes = {};
  PipeMap(super.field) {
    forEach((x, y) {
      if (getValueAt(x, y) == "S") {
        start = Position(x, y);
        return;
      }
    });
  }

  /// Returns the value at the given position.
  @override
  String? getValueAtPosition(Position position) =>
      isOnField(position) ? field[position.y][position.x] : null;

  Iterable<Position> connectedPipes([Position? from]) {
    from ??= start;
    return _connectedPipes.putIfAbsent(from, () {
      var aPipes = adjacentPipes(from!);
      var filteredPipes = [aPipes.north, aPipes.south, aPipes.west, aPipes.east]
          .mapNotNull((element) => element)
          .toIterable();
      assert(filteredPipes.length == 2);
      return filteredPipes;
    });
  }

  /// Returns all adjacent pipes to the given position, if they are plausible. This does `NOT` include
  /// diagonal neighbours.
  ({Position? north, Position? south, Position? east, Position? west})
      adjacentPipes(Position from) {
    Position? north;
    Position? south;
    Position? east;
    Position? west;
    // check from bottom
    south = ["|", "L", "J", "S"]
            .contains(getValueAtPosition(Position(from.x, from.y + 1)))
        ? Position(from.x, from.y + 1)
        : null;
    north = ["|", "F", "7", "S"]
            .contains(getValueAtPosition(Position(from.x, from.y - 1)))
        ? Position(from.x, from.y - 1)
        : null;
    east = ["-", "7", "J", "S"]
            .contains(getValueAtPosition(Position(from.x + 1, from.y)))
        ? Position(from.x + 1, from.y)
        : null;
    west = ["-", "L", "F", "S"]
            .contains(getValueAtPosition(Position(from.x - 1, from.y)))
        ? Position(from.x - 1, from.y)
        : null;
    return (north: north, south: south, east: east, west: west);
  }
}

class Day10 extends GenericDay {
  final String inType;
  Day10([this.inType = 'in']) : super(10, inType);

  @override
  PipeMap parseInput() {
    final lines = input.getPerLine();
    return PipeMap(lines.map((element) => element.split("")).toList());
  }

  @override
  int solvePartA() {
    final pipeMap = parseInput();
    List<Position> loop = [pipeMap.start, pipeMap.connectedPipes().first];
    bool looped = false;
    Position? next = loop.last;
    while (!looped) {
      var possibleNexts = pipeMap.connectedPipes(next);
      if (loop.contains(possibleNexts.first)) {
        if (loop.contains(possibleNexts.last)) {
          looped = true;
        }
        next = possibleNexts.last;
      } else {
        next = possibleNexts.first;
      }
    }

    return (loop.length / 2).floor();
  }

  @override
  int solvePartB() {
    // TODO implement
    return 0;
  }
}
