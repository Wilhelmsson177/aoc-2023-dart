import 'package:aoc/index.dart';
import 'package:dartx/dartx.dart';

class Day06 extends GenericDay {
  final String inType;
  Day06([this.inType = 'in']) : super(6, inType);

  @override
  (Iterable<int>, Iterable<int>) parseInput() {
    final lines = input.getPerLine();
    RegExp exp = RegExp(r'\d+');
    Iterable<int> times =
        exp.allMatches(lines[0]).map((e) => int.tryParse(e[0]!)).map(
              (e) => e!,
            );
    Iterable<int> distances =
        exp.allMatches(lines[1]).map((e) => int.tryParse(e[0]!)).map(
              (e) => e!,
            );
    return (times, distances);
  }

  int calculation(int input, int duration) {
    return (duration - input) * input;
  }

  @override
  int solvePartA() {
    final input = parseInput();
    Iterable<int> times = input.$1;
    List<int> distances = input.$2.toList();
    int result = 1;
    for (var time in times.indexed) {
      int myWins = 1
          .rangeTo(time.$2)
          .map((e) => calculation(e, time.$2))
          .count((e) => e > distances[time.$1]);
      result *= myWins;
    }
    return result;
  }

  @override
  int solvePartB() {
    final input = parseInput();
    int time = input.$1.join().toInt();
    int distance = input.$2.join().toInt();
    return 1
        .rangeTo(time)
        .map((e) => calculation(e, time))
        .count((e) => e > distance);
  }
}
