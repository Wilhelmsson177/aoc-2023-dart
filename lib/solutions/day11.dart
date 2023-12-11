import 'package:aoc/index.dart';
import 'package:aoc/logger.dart';
import 'package:dartx/dartx.dart';

class GalaxyMap<String> extends Field {
  List<Position> galaxies = [];
  GalaxyMap(super.field) {
    talker.verbose(toString());
    List<int> extensionRows = [];
    for (var i = 0; i < height; i++) {
      var row = getRow(i);
      if (row.all((element) => element == ".")) {
        extensionRows.add(i);
      }
    }
    List<int> extensionCols = [];
    for (var i = 0; i < width; i++) {
      var row = getColumn(i);
      if (row.all((element) => element == ".")) {
        extensionCols.add(i);
      }
    }

    for (var (index, element) in extensionRows.indexed) {
      field.insert(element + index, List.filled(width, '.', growable: true));
    }
    talker.verbose(toString());
    height = field.length;
    width = field[0].length;
    for (var (index, element) in extensionCols.indexed) {
      for (var i = 0; i < height; i++) {
        field[i].insert(element + index, '.');
      }
    }
    height = field.length;
    width = field[0].length;
    talker.verbose(toString());

    forEach((x, y) {
      if (getValueAt(x, y) == "#") {
        galaxies.add(Position(x, y));
      }
    });
  }

  List<(Position, Position)> get combinations {
    final List<(Position, Position)> combinations = [];
    for (int i = 0; i < galaxies.length; i++) {
      for (int j = i + 1; j < galaxies.length; j++) {
        combinations.add((galaxies[i], galaxies[j]));
      }
    }
    return combinations;
  }
}

int manhattanDistance(Position p1, Position p2) {
  int dx = p1.x - p2.x;
  int dy = p1.y - p2.y;
  return dx.abs() + dy.abs();
}

class Day11 extends GenericDay {
  final String inType;
  Day11([this.inType = 'in']) : super(11, inType);

  @override
  GalaxyMap parseInput() {
    final lines = input.getPerLine();
    GalaxyMap galaxyMap =
        GalaxyMap(lines.map((element) => element.split("")).toList());
    return galaxyMap;
  }

  @override
  int solvePartA() {
    List<int> distances = [];
    final galaxyMap = parseInput();
    for (var (first, second) in galaxyMap.combinations) {
      distances.add(manhattanDistance(first, second));
    }
    return distances.fold(
        0, (previousValue, element) => previousValue + element);
  }

  @override
  int solvePartB() {
    // TODO implement
    return 0;
  }
}
