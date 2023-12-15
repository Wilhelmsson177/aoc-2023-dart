import 'package:aoc/index.dart';
import 'package:aoc/logger.dart';
import 'package:dartx/dartx.dart' hide IterableMapIndexed;

class Lens {
  String label;
  int focalLength;
  Lens(this.label, this.focalLength);

  @override
  String toString() {
    return "$label $focalLength";
  }
}

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
    List<List<Lens>> boxes = List<List<Lens>>.generate(
        256, (index) => List<Lens>.empty(growable: true));
    List<String> instructions = parseInput();
    for (String inst in instructions) {
      String label = inst.split(RegExp(r"[-=]")).first;
      int relevantBox = lensHash(label);
      if (inst.contains("-")) {
        boxes[relevantBox].removeWhere((element) => element.label == label);
      }
      if (inst.contains("=")) {
        int focalLength = inst.split("=").last.toInt();
        Lens newLens = Lens(label, focalLength);
        int index =
            boxes[relevantBox].indexWhere((element) => element.label == label);
        if (index > -1) {
          boxes[relevantBox].removeAt(index);
          boxes[relevantBox].insert(index, newLens);
        } else {
          boxes[relevantBox].add(newLens);
        }
      }
      talker.verbose(boxes.where((element) => element.isNotEmpty));
    }
    return boxes.foldIndexed(
        0, (index, previous, element) => previous + focusPower(index, element));
  }
}

int focusPower(int boxIndex, List<Lens> lenses) {
  return lenses
      .map((e) => e.focalLength)
      .mapIndexed((index, element) => element * (index + 1) * (boxIndex + 1))
      .fold(0, (previousValue, element) => previousValue + element);
}

int lensHash(String element) =>
    element.split("").fold(0, (previousValue, element) {
      previousValue += element.codeUnitAt(0);
      previousValue *= 17;
      return previousValue % 256;
    });
