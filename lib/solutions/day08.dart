import 'package:aoc/index.dart';

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
    bool foundDestination = false;
    String next = "AAA";
    while (!foundDestination) {
      String nextTurn = directions.substring(
          counter % directions.length, counter % directions.length + 1);

      next = switch (nextTurn) {
        "R" => map[next]!.right,
        "L" => map[next]!.left,
        _ => throw Error()
      };
      counter += 1;
      if (next == "ZZZ") {
        foundDestination = true;
      }
    }
    return counter;
  }

  @override
  int solvePartB() {
    // TODO implement
    return 0;
  }
}
