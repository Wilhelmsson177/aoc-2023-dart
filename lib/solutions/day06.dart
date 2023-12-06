import 'package:aoc/index.dart';
import 'package:dartx/dartx.dart';
import 'package:equations/equations.dart';

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

  @override
  int solvePartA() {
    final input = parseInput();
    Iterable<int> times = input.times;
    List<int> distances = input.distances.toList();
    List<int> wins = [];
    for (var (index, time) in times.indexed) {
      wins.add(equation(
          time.toDouble(), distances[index].toDouble() + 0.00000000001));
    }
    return wins.fold(1, (previousValue, element) => previousValue * element);
  }

  @override
  int solvePartB() {
    final input = parseInput();
    double time = input.times.join().toDouble();
    double distance = input.distances.join().toDouble() + 0.000000000001;
    return equation(time, distance);
  }

  int equation(double time, double distance) {
    final equation = Quadratic(
        a: Complex.fromReal(-1),
        b: Complex.fromReal(time),
        c: Complex.fromReal(-distance));
    return equation.solutions().last.real.truncate() -
        equation.solutions().first.real.truncate();
  }
}
