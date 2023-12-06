import 'package:aoc/index.dart';
import 'package:dartx/dartx.dart';

class Day06 extends GenericDay {
  final String inType;
  Day06([this.inType = 'in']) : super(6, inType);

  @override
  ({Iterable<int> times, Iterable<int> distances}) parseInput() {
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
    return (times: times, distances: distances);
  }

  int calculation(int input, int duration) {
    return (duration - input) * input;
  }

  @override
  int solvePartA() {
    final input = parseInput();
    Iterable<int> times = input.times;
    List<int> distances = input.distances.toList();
    int result = 1;
    for (var (index, time) in times.indexed) {
      int myWins = 1
          .rangeTo(time)
          .map((e) => calculation(e, time))
          .count((e) => e > distances[index]);
      result *= myWins;
    }
    return result;
  }

  @override
  int solvePartB() {
    final input = parseInput();
    int time = input.times.join().toInt();
    int distance = input.distances.join().toInt();
    return 1
        .rangeTo(time)
        .map((e) => calculation(e, time))
        .count((e) => e > distance);
  }
}
