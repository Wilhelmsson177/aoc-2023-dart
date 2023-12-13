import 'package:aoc/index.dart';
import 'package:aoc/logger.dart';
import 'package:dartx/dartx.dart';

class Reflector extends Field {
  Reflector(super.field);
  int findReflections() {
    // find vertical reflection
    for (var i = 1; i < width; i++) {
      var first = getColumn(i - 1).join("");
      var second = getColumn(i).join("");
      if (first == second &&
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
    // TODO implement
    return 0;
  }
}
