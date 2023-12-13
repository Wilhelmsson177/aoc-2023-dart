import 'package:aoc/index.dart';
import 'package:aoc/logger.dart';

class Reflector extends Field {
  Reflector(super.field);
  int findReflections() {
    // find initial vertical reflection
    int initialVerticalReflection = -1;
    int verticalCount = 1;
    for (var i = 0; i < width - 1; i++) {
      var first = getColumn(i).join("");
      var second = getColumn(i + 1).join("");
      if (first == second) {
        initialVerticalReflection = i;
        break;
      }
    }
    talker.verbose("Initial vertical reflection: $initialVerticalReflection");
    // find following reflections
    if (initialVerticalReflection > 0) {
      // possible width
      int possibleWidth = min(
          [initialVerticalReflection, width - initialVerticalReflection - 1])!;
      for (var i = 0; i < possibleWidth; i++) {
        var first = getColumn(initialVerticalReflection - i).join("");
        var second = getColumn(initialVerticalReflection + 1 + i).join("");
        if (first == second) {
          verticalCount++;
        } else {
          break;
        }
      }
      talker.verbose("Total vertical reflections: $verticalCount");
      if (verticalCount > possibleWidth) {
        return initialVerticalReflection + 1;
      }
    }

    // find initial horizontal reflection
    int initialHorizontalReflection = -1;
    int horizontalCount = 1;
    for (var i = 0; i < height - 1; i++) {
      var first = getRow(i).join("");
      var second = getRow(i + 1).join("");
      if (first == second) {
        initialHorizontalReflection = i;
        break;
      }
    }
    talker
        .verbose("Initial horizontal reflection: $initialHorizontalReflection");
    // find following reflections
    if (initialHorizontalReflection > 0) {
      // possible width
      int possibleHeight = min([
        initialHorizontalReflection,
        height - initialHorizontalReflection - 1
      ])!;
      for (var i = 0; i < possibleHeight; i++) {
        var first = getRow(initialHorizontalReflection - i).join("");
        var second = getRow(initialHorizontalReflection + 1 + i).join("");
        if (first == second) {
          horizontalCount++;
        } else {
          break;
        }
      }
      talker.verbose("Total horizontal reflections: $horizontalCount");
    }

    return 100 * (initialHorizontalReflection + 1);
  }
}

class Day13 extends GenericDay {
  final String inType;
  Day13([this.inType = 'in']) : super(13, inType);

  @override
  Iterable<Reflector> parseInput() {
    final blocks = input.getPerBlock();
    return blocks
        .takeWhile((value) => value.isNotEmpty)
        .map((e) => Reflector(ParseUtil.blockToFieldLike(e)));
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
