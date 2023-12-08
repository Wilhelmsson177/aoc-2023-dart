import 'package:aoc/index.dart';
import 'package:aoc/logger.dart';
import 'package:dartx/dartx.dart';
import 'package:dart_numerics/dart_numerics.dart';

typedef Follower = ({String left, String right});

class Day08 extends GenericDay {
  final String inType;
  Day08([this.inType = 'in']) : super(8, inType);

  @override
  (String, Map<String, Follower>) parseInput() {
    String directions = input.getPerLine().first;
    Map<String, Follower> follower = <String, Follower>{
      for (var v in input.getPerLine().skip(2))
        v.substring(0, 3): (
          left: v.substring(7, 10),
          right: v.substring(12, 15)
        )
    };
    return (directions, follower);
  }

  @override
  int solvePartA() {
    (String, Map<String, Follower>) input = parseInput();
    String directions = input.$1;
    Map<String, Follower> map = input.$2;
    int counter = 0;

    String current = "AAA";
    while (current != "ZZZ") {
      counter += 1;
      current = switch (directions.substring(0, 1)) {
        "R" => map[current]!.right,
        "L" => map[current]!.left,
        _ => throw Error()
      };
      directions = directions.substring(1) + directions.substring(0, 1);
    }
    return counter;
  }

  @override
  int solvePartB() {
    (String, Map<String, Follower>) input = parseInput();
    String directions = input.$1;
    Map<String, Follower> map = input.$2;
    List<String> starts =
        map.keys.filter((element) => element.endsWith("A")).toList();
    talker.debug(starts);
    List<int> cycles = [];
    for (var current in starts) {
      var currentSteps = directions;
      var stepCount = 0;
      while (!current.endsWith("Z")) {
        stepCount++;
        current = switch (currentSteps.substring(0, 1)) {
          "R" => map[current]!.right,
          "L" => map[current]!.left,
          _ => throw Error()
        };
        currentSteps = currentSteps.substring(1) + currentSteps.substring(0, 1);
      }
      cycles.add(stepCount);
    }
    talker.debug(cycles);
    return leastCommonMultipleOfMany(cycles);
  }
}
