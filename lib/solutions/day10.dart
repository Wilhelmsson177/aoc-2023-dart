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
      return [aPipes.north, aPipes.south, aPipes.west, aPipes.east]
          .mapNotNull((element) => element)
          .toIterable();
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
    north = ["|", "F", "7"]
            .contains(getValueAtPosition(Position(from.x, from.y + 1)))
        ? Position(from.x, from.y - 1)
        : null;
    south = ["|", "L", "J"]
            .contains(getValueAtPosition(Position(from.x, from.y - 1)))
        ? Position(from.x, from.y - 1)
        : null;
    east = ["-", "7", "F"]
            .contains(getValueAtPosition(Position(from.x + 1, from.y)))
        ? Position(from.x, from.y - 1)
        : null;
    west = ["-", "L", "F"]
            .contains(getValueAtPosition(Position(from.x - 1, from.y)))
        ? Position(from.x, from.y - 1)
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
      next = pipeMap.connectedPipes(next).firstWhere(
            (element) => !loop.contains(element),
            orElse: () => loop.first,
          );
      if (next == loop.first) {
        looped = true;
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
