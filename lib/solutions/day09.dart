import 'package:aoc/index.dart';
import 'package:aoc/logger.dart';
import 'package:dartx/dartx.dart';

class Day09 extends GenericDay {
  final String inType;
  Day09([this.inType = 'in']) : super(9, inType);

  @override
  Iterable<List<int>> parseInput() {
    final lines = input.getPerLine();
    return lines
        .map((element) => ParseUtil.stringListToIntList(element.split(" ")));
  }

  @override
  int solvePartA() {
    final input = parseInput();
    int sum = 0;
    for (var element in input) {
      sum += predictFuture(element);
      talker.debug(sum);
    }
    return sum;
  }

  @override
  int solvePartB() {
    final input = parseInput();
    int sum = 0;
    for (var element in input) {
      sum += predictHistory(element);
      talker.debug(sum);
    }
    return sum;
  }
}

List<int> getDiff(List<int> element) {
  List<int> diff = [];
  for (var i = 0; i < element.length - 1; i++) {
    diff.add((element[i + 1] - element[i]));
  }
  return diff;
}

int predictHistory(List<int> element) {
  List<List<int>> diffs = [element];
  do {
    diffs.add(getDiff(diffs.last));
  } while (!diffs.last.all((element) => element == 0));
  talker.debug(diffs);
  int newValue = 0;
  for (var i = diffs.length - 1; i > 0; i--) {
    diffs[i].insert(0, newValue);
    newValue = diffs[i - 1].first - newValue;
  }
  diffs.first.insert(0, newValue);
  talker.debug(diffs);
  return diffs.first.first;
}

int predictFuture(List<int> element) {
  List<List<int>> diffs = [element];
  do {
    diffs.add(getDiff(diffs.last));
  } while (!diffs.last.all((element) => element == 0));
  talker.debug(diffs);
  int newValue = 0;
  for (var i = diffs.length - 1; i > 0; i--) {
    diffs[i].add(newValue);
    newValue = newValue + diffs[i - 1].last;
  }
  diffs.first.add(newValue);
  talker.debug(diffs);
  return diffs.first.last;
}
