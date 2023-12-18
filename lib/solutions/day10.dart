import 'package:aoc/general.dart';
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

    String value = getValueAtPosition(from)!;
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
    switch (value) {
      case "-":
        south = null;
        north = null;
        break;
      case "|":
        east = null;
        west = null;
        break;
      case "J":
        south = null;
        east = null;
        break;
      case "7":
        north = null;
        east = null;
        break;
      case "F":
        north = null;
        west = null;
        break;
      case "L":
        west = null;
        south = null;
        break;
      default:
        break;
    }
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
    while (pipeMap.getValueAtPosition(loop.last) != "S") {
      var possibleNexts = pipeMap.connectedPipes(loop.last);
      if (loop.contains(possibleNexts.first)) {
        if (loop.contains(possibleNexts.last)) {
          break;
        }
        loop.add(possibleNexts.last);
      } else {
        loop.add(possibleNexts.first);
      }
    }

    return (loop.length / 2).floor();
  }

  @override
  int solvePartB() {
    final pipeMap = parseInput();
    List<Position> loop = [pipeMap.start, pipeMap.connectedPipes().first];
    while (pipeMap.getValueAtPosition(loop.last) != "S") {
      var possibleNexts = pipeMap.connectedPipes(loop.last);
      if (loop.contains(possibleNexts.first)) {
        if (loop.contains(possibleNexts.last)) {
          break;
        }
        loop.add(possibleNexts.last);
      } else {
        loop.add(possibleNexts.first);
      }
    }
    var area = calculatePolygonArea(loop);
    // i = A - b/2 - h + 1
    // h is 0 because no holes expected
    return area.abs() - (loop.length / 2).floor() + 1;
  }
}
