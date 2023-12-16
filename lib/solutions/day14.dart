import 'package:aoc/index.dart';
import 'package:dartx/dartx.dart';

class Dish extends Field<String> {
  Dish(super.field);

  int get weight {
    int weight = 0;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        if (getValueAt(x, y) == "O") {
          int skips = getColumn(x)
              .take(y)
              .reversed
              .takeWhile((value) => value != "#")
              .filter((element) => element == ".")
              .count();
          weight += height - y + skips;
        }
      }
    }
    return weight;
  }

  int get currentWeight {
    int weight = 0;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        if (getValueAt(x, y) == "O") {
          weight += height - y;
        }
      }
    }
    return weight;
  }

  void rollNorth() {}
}

class Day14 extends GenericDay {
  final String inType;
  Day14([this.inType = 'in']) : super(14, inType);

  @override
  Dish parseInput() {
    return Dish(input.getPerLine().map((e) => e.split("")).toList());
  }

  @override
  int solvePartA() {
    final plate = parseInput();
    plate.rollNorth();
    return plate.weight;
  }

  @override
  int solvePartB() {
    // TODO implement
    return 0;
  }
}
