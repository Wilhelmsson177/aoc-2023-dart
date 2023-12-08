import 'package:aoc/index.dart';
import 'package:dartx/dartx.dart';

class RangeDesc {
  late int destination;
  late int source;
  late int rangeLength;

  RangeDesc(String input) {
    var splits = input.trim().split(" ");
    destination = splits[0].toInt();
    source = splits[1].toInt();
    rangeLength = splits[2].toInt();
  }

  bool sourceContains(int num) {
    return num >= source && num <= source + rangeLength;
  }
}

class CategoryMapping {
  List<RangeDesc> ranges = [];
  String from;
  String to;
  CategoryMapping? next;

  CategoryMapping(this.from, this.to, this.next, String input) {
    input.split("\n").forEach((element) {
      if (!element.endsWith(":") && element.isNotEmpty) {
        ranges.add(RangeDesc(element));
      }
    });
  }

  int? getNext(int input) {
    int nextStep = _findNext(input);
    return next != null ? next?.getNext(nextStep) : nextStep;
  }

  int _findNext(int input) {
    for (RangeDesc range in ranges) {
      if (range.sourceContains(input)) {
        return input + (range.destination - range.source);
      }
    }
    return input;
  }
}

class Day05 extends GenericDay {
  final String inType;
  Day05([this.inType = 'in']) : super(5, inType);

  @override
  (Iterable<int>, CategoryMapping) parseInput() {
    final content = input.asString;
    Iterable<int> seeds = content
        .split("\n")
        .first
        .split(":")
        .last
        .trim()
        .split(" ")
        .map((e) => e.toInt());
    List<String> mappingStrings = content.split("\n\n");
    CategoryMapping humidityToLocation =
        CategoryMapping("humidity", "location", null, mappingStrings[7]);
    CategoryMapping temperatureToHumidity = CategoryMapping(
        "temperature", "humidity", humidityToLocation, mappingStrings[6]);
    CategoryMapping lightToTemperatur = CategoryMapping(
        "light", "temperatur", temperatureToHumidity, mappingStrings[5]);
    CategoryMapping waterToLight =
        CategoryMapping("water", "light", lightToTemperatur, mappingStrings[4]);
    CategoryMapping fertilizerToWater =
        CategoryMapping("fertilizer", "water", waterToLight, mappingStrings[3]);
    CategoryMapping soilToFertilizer = CategoryMapping(
        "soil", "fertilizer", fertilizerToWater, mappingStrings[2]);
    CategoryMapping seedToSoil =
        CategoryMapping("seed", "soil", soilToFertilizer, mappingStrings[1]);
    return (seeds, seedToSoil);
  }

  @override
  int solvePartA() {
    (Iterable<int>, CategoryMapping) content = parseInput();
    int closestLocation = -1;
    for (int seed in content.$1) {
      if (closestLocation == -1) {
        closestLocation = content.$2.getNext(seed)!;
      } else {
        closestLocation = min([closestLocation, content.$2.getNext(seed)!])!;
      }
    }
    return closestLocation;
  }

  @override
  int solvePartB() {
    (Iterable<int>, CategoryMapping) content = parseInput();
    int closestLocation = -1;

    partition(content.$1, 2).map((e) => (e[0], e[1])).forEach((element) {
      for (int seed in element.$1.rangeTo(element.$1 + element.$2 - 1)) {
        if (closestLocation == -1) {
          closestLocation = content.$2.getNext(seed)!;
        } else {
          closestLocation = min([closestLocation, content.$2.getNext(seed)!])!;
        }
      }
    });
    return closestLocation;
  }
}
