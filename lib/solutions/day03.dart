import 'package:aoc/index.dart';
import 'package:dartx/dartx.dart';

class Day03 extends GenericDay {
  final String inType;
  Day03([this.inType = 'in']) : super(3, inType);

  @override
  (Set<String>, Field<String>) parseInput() {
    String completeInput = input.asString;
    Set<String> allSymbols = completeInput
        .replaceAll(".", "")
        .replaceAll(RegExp(r"\d"), "")
        .replaceAll("\n", "")
        .split("")
        .toSet();
    Field<String> field =
        Field(input.getPerLine().map((e) => e.split("")).toList());
    return (allSymbols, field);
  }

  @override
  int solvePartA() {
    var input = parseInput();
    Set<String> allSymbols = input.$1;
    Field<String> field = input.$2;
    List<int> partNumbers = [];

    field.forEach((p0, p1) {
      if (allSymbols.contains(field.getValueAtPosition(Position(p0, p1)))) {
        Set<int> foundPartNumbers = {};
        for (Position n in field.neighbours(p0, p1)) {
          if (field.getValueAtPosition(n).isInt) {
            // Find direction of number
            if (p0 == n.x) {
              // Can be either direction
              // Must not be covered Individually, because it should be found be the other two cases
              // Only issue could be, if a single digit number
              if (!field.getValueAt(n.x - 1, n.y).isInt &&
                  !field.getValueAt(n.x + 1, n.y).isInt) {
                foundPartNumbers.add(field.getValueAtPosition(n).toInt());
              }
            } else if (p0 > n.x) {
              // n is last digit
              int index = 0;
              StringBuffer partNumber = StringBuffer();
              do {
                partNumber.write(field.getValueAt(n.x + index, n.y));
                index--;
              } while (field.isOnField(Position(n.x + index, n.y)) &&
                  field.getValueAt(n.x + index, n.y).isInt);
              foundPartNumbers.add(partNumber.toString().reversed.toInt());
            } else if (p0 < n.x) {
              // n is first digit
              int index = 0;
              StringBuffer partNumber = StringBuffer();
              do {
                partNumber.write(field.getValueAt(n.x + index, n.y));
                index++;
              } while (field.isOnField(Position(n.x + index, n.y)) &&
                  field.getValueAt(n.x + index, n.y).isInt);
              foundPartNumbers.add(partNumber.toString().toInt());
            }
          }
        }
        partNumbers.addAll(foundPartNumbers);
      }
    });
    return partNumbers.reduce((value, element) => value + element);
  }

  @override
  int solvePartB() {
    // TODO implement
    return 0;
  }
}
