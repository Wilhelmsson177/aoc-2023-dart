import 'package:aoc/index.dart';
import 'package:aoc/logger.dart';
import 'package:dartx/dartx.dart';

class GalaxyMap<String> extends Field {
  List<Position> galaxies = [];
  List<int> extensionRows = [];
  List<int> extensionCols = [];

  GalaxyMap(super.field, [int extension = 1, bool simulateExtension = true]) {
    talker.verbose(toString());
    for (var i = 0; i < height; i++) {
      var row = getRow(i);
      if (row.all((element) => element == ".")) {
        extensionRows.add(i);
      }
    }

    for (var i = 0; i < width; i++) {
      var row = getColumn(i);
      if (row.all((element) => element == ".")) {
        extensionCols.add(i);
      }
    }

    if (simulateExtension) {
      for (var (index, element) in extensionRows.indexed) {
        int extensionCounter = 1;
        for (var i = 0; i < extension; i++) {
          field.insert(element + (index * extensionCounter),
              List.filled(width, '.', growable: true));
        }
        extensionCounter += extension;
      }
      talker.verbose(toString());
      height = field.length;
      width = field[0].length;
      for (var (index, element) in extensionCols.indexed) {
        int extensionCounter = 1;
        for (var i = 0; i < extension; i++) {
          for (var i = 0; i < height; i++) {
            field[i].insert(element + (index * extensionCounter), '.');
          }
        }
        extensionCounter += extension;
      }
      height = field.length;
      width = field[0].length;
      talker.verbose(toString());
    }

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
  GalaxyMap parseInput(
      {int extensionFactor = 1, bool simulateExtension = true}) {
    final lines = input.getPerLine();
    GalaxyMap galaxyMap = GalaxyMap(
        lines.map((element) => element.split("")).toList(),
        extensionFactor,
        simulateExtension);
    return galaxyMap;
  }

  @override
  int solvePartA({bool simulateExtension = true}) {
    List<int> distances = [];
    final galaxyMap = parseInput(simulateExtension: simulateExtension);
    for (var (first, second) in galaxyMap.combinations) {
      var mD = manhattanDistance(first, second);
      talker.verbose((first, second, mD));
      distances.add(mD);
    }
    return distances.fold(
        0, (previousValue, element) => previousValue + element);
  }

  @override
  int solvePartB({int extensionFactor = 1000000}) {
    extensionFactor = extensionFactor - 1;
    List<int> distances = [];
    final galaxyMap =
        parseInput(extensionFactor: extensionFactor, simulateExtension: false);
    for (var (first, second) in galaxyMap.combinations) {
      int dx = (first.x - second.x).abs();
      int dy = (first.y - second.y).abs();
      int startX = first.x < second.x ? first.x : second.x;
      int startY = first.y < second.y ? first.y : second.y;
      int xFactor = range(startX, startX + dx)
          .toSet()
          .intersection(galaxyMap.extensionCols.toSet())
          .length;
      int yFactor = range(startY, startY + dy)
          .toSet()
          .intersection(galaxyMap.extensionRows.toSet())
          .length;
      var mD =
          dx + dy + (extensionFactor * xFactor) + (extensionFactor * yFactor);
      talker.verbose((first, second, mD));
      distances.add(mD);
    }
    return distances.fold(
        0, (previousValue, element) => previousValue + element);
  }
}
