import 'package:aoc/index.dart';

class Day15 extends GenericDay {
  final String inType;
  Day15([this.inType = 'in']) : super(15, inType);

  @override
  List<String> parseInput() {
    return input.getBy(",");
  }

  @override
  int solvePartA() {
    return parseInput()
        .fold(0, (previousValue, element) => previousValue + lensHash(element));
  }

  @override
  int solvePartB() {
    // TODO implement
    return 0;
  }
}

int lensHash(String element) =>
    element.split("").fold(0, (previousValue, element) {
      previousValue += element.codeUnitAt(0);
      previousValue *= 17;
      return previousValue % 256;
    });
