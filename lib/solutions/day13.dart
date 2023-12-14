import 'package:aoc/index.dart';
import 'package:aoc/logger.dart';
import 'package:dartx/dartx.dart';
import 'package:quiver/collection.dart';

class Reflector extends Field {
  Reflector(super.field);
  int findReflections() {
    // find vertical reflection
    for (var i = 1; i < width; i++) {
      String firstRow = getColumn(i - 1).join("");
      var second = getColumn(i).join("");
      if (firstRow == second &&
          range(0, i)
              .map((e) => getColumn(e as int).join(""))
              .reversed
              .zip(range(i, width).map((e) => getColumn(e as int).join("")),
                  (a, b) => (a, b))
              .all((element) => element.$1 == element.$2)) {
        talker.verbose("Vertical: $i");
        return i;
      }
    }

    // find horizontal reflection
    for (var i = 1; i < height; i++) {
      var first = getRow(i - 1).join("");
      var second = getRow(i).join("");
      if (first == second &&
          range(0, i)
              .map((e) => getRow(e as int).join(""))
              .reversed
              .zip(range(i, height).map((e) => getRow(e as int).join("")),
                  (a, b) => (a, b))
              .all((element) => element.$1 == element.$2)) {
        talker.verbose("Horizontal: $i");
        return i * 100;
      }
    }
    talker.warning(toString());
    throw Error();
  }

  int findSmudge() {
    // find vertical reflection
    for (var split in range(width - 1)) {
      int smudges = 0;
      for (var i in range(split + 1)) {
        if (split + i + 1 >= width) {
          continue;
        }

        var columnLeft = getColumn((split as int) - 1);
        var columnRight = getColumn((split) + (i as int) + 1);

        smudges += columnLeft.zip(columnRight, (a, b) => (a != b)).count();
      }
      if (smudges == 1) {
        return (split as int) + 1;
      }
    }

    // find horizontal reflection
    for (var i = 1; i < height; i++) {
      var first = getRow(i - 1).join("");
      var second = getRow(i).join("");
      if (first == second &&
          range(0, i)
              .map((e) => getRow(e as int).join(""))
              .reversed
              .zip(range(i, height).map((e) => getRow(e as int).join("")),
                  (a, b) => (a, b))
              .all((element) => element.$1 == element.$2)) {
        talker.verbose("Horizontal: $i");
        return i * 100;
      }
    }
    talker.warning(toString());
    return 0;
  }
}

class Day13 extends GenericDay {
  final String inType;
  Day13([this.inType = 'in']) : super(13, inType);

  @override
  Iterable<Reflector> parseInput() {
    final blocks = input.getPerBlock();
    return blocks.map((e) => Reflector(ParseUtil.blockToFieldLike(e.trim())));
  }

  @override
  int solvePartA() {
    final mirrors = parseInput();
    return mirrors.fold(0,
        (previousValue, element) => previousValue + element.findReflections());
  }

  @override
  int solvePartB() {
    final mirrors = parseInput();
    return mirrors.fold(
        0, (previousValue, element) => previousValue + element.findSmudge());
  }
}
