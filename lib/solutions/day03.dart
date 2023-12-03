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
    Map<(Position, Position), int> numbers = {};
    for (int rowIndex = 0; rowIndex < field.height; rowIndex++) {
      var row = field.getRow(rowIndex);
      RegExp reNum = RegExp(r"\d+");
      // row must be a real string
      for (var match in reNum.allMatches(row.join())) {
        Position startP = Position(match.start, rowIndex);
        Position endP = Position(match.end - 1, rowIndex);
        numbers.putIfAbsent((startP, endP), () => match[0]!.toInt());
      }
    }

    for (MapEntry<(Position, Position), int> possiblePartNumber
        in numbers.entries) {
      if (checkSymbol(field, possiblePartNumber.key.$1, allSymbols) ||
          checkSymbol(field, possiblePartNumber.key.$2, allSymbols)) {
        partNumbers.add(possiblePartNumber.value);
      }
    }

    return partNumbers.reduce((value, element) => value + element);
  }

  @override
  int solvePartB() {
    var input = parseInput();
    Field<String> field = input.$2;
    List<int> partNumbers = [];
    Map<(Position, Position), int> numbers = {};
    for (int rowIndex = 0; rowIndex < field.height; rowIndex++) {
      var row = field.getRow(rowIndex);
      RegExp reNum = RegExp(r"\d+");
      // row must be a real string
      for (var match in reNum.allMatches(row.join())) {
        Position startP = Position(match.start, rowIndex);
        Position endP = Position(match.end - 1, rowIndex);
        numbers.putIfAbsent((startP, endP), () => match[0]!.toInt());
      }
    }
    Map<Position, Set<int>> gears = {};
    for (MapEntry<(Position, Position), int> possiblePartNumber
        in numbers.entries) {
      if (checkSymbol(field, possiblePartNumber.key.$1, {"*"}) ||
          checkSymbol(field, possiblePartNumber.key.$2, {"*"})) {
        partNumbers.add(possiblePartNumber.value);
      }
      Position? gearStart = getGear(field, possiblePartNumber.key.$1);
      Position? gearEnd = getGear(field, possiblePartNumber.key.$2);
      if (gearStart != null) {
        if (gears.containsKey(gearStart)) {
          gears[gearStart]!.add(possiblePartNumber.value);
        } else {
          gears.putIfAbsent(gearStart, () => {possiblePartNumber.value});
        }
      }
      if (gearEnd != null) {
        if (gears.containsKey(gearEnd)) {
          gears[gearEnd]!.add(possiblePartNumber.value);
        } else {
          gears.putIfAbsent(gearEnd, () => {possiblePartNumber.value});
        }
      }
    }

    int sum = 0;
    for (MapEntry<Position, Set<int>> gear in gears.entries) {
      if (gear.value.length == 2) {
        sum += gear.value.first * gear.value.last;
      }
    }

    return sum;
  }
}

Position? getGear(Field<String> field, Position pos) {
  for (Position n in field.neighbours(pos.x, pos.y)) {
    if (field.getValueAtPosition(n) == "*") {
      return n;
    }
  }
  return null;
}

bool checkSymbol(Field<String> field, Position pos, Set<String> allSymbols) {
  return field.neighbours(pos.x, pos.y).any(
      (element) => allSymbols.contains(field.getValueAt(element.x, element.y)));
}
