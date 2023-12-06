import 'package:aoc/index.dart';
import 'package:dartx/dartx.dart' hide IterableSorted;
import 'package:interval_tree/interval_tree.dart';
import 'package:talker/talker.dart';

class Range {
  late int destination;
  late int source;
  late int rangeLength;
  late (int, int) boundaries;

  Range(String input) {
    var splits = input.trim().split(" ");
    destination = splits[0].toInt();
    source = splits[1].toInt();
    rangeLength = splits[2].toInt();
    boundaries = (source, source + rangeLength);
  }

  bool sourceContains(int num) {
    return num >= source && num <= source + rangeLength;
  }
}

class Almanac {
  List<Range> maps = [];
  Almanac(String input) {
    input.trim().split("\n").skip(1).forEach((element) {
      maps.add(Range(element));
    });
    maps.sort((a, b) => a.boundaries.$1.compareTo(b.boundaries.$1));
  }

  int destination(int source) {
    for (Range range in maps) {
      if (range.sourceContains(source)) {
        return source + (range.destination - range.source);
      }
    }
    return source;
  }

  get boundaries {
    return maps.map((e) => e.boundaries).toIterable();
  }

  get sources {
    return maps.map((e) => e).toIterable();
  }
}

class Day05 extends GenericDay {
  final String inType;
  TalkerLogger talker = TalkerLogger();
  Day05([this.inType = 'in']) : super(5, inType);

  @override
  (Iterable<int>, List<Almanac>) parseInput() {
    final content = input.asString;
    Iterable<int> seeds = content
        .split("\n")
        .first
        .split(":")
        .last
        .trim()
        .split(" ")
        .map((e) => e.toInt());
    List<Almanac> almanacs = [];
    content.split("\n\n").skip(1).forEach((element) {
      almanacs.add(Almanac(element));
    });
    return (seeds, almanacs);
  }

  @override
  int solvePartA() {
    (Iterable<int>, List<Almanac>) content = parseInput();
    List<int> locations = [];
    Iterable<int> seeds = content.$1;
    List<Almanac> almanacs = content.$2;
    for (int source in seeds) {
      int destination = source;
      for (Almanac a in almanacs) {
        destination = a.destination(source);
        source = destination;
      }
      locations.add(destination);
    }
    return min(locations)!;
  }

  @override
  int solvePartB() {
    (Iterable<int>, List<Almanac>) content = parseInput();
    Iterable<int> seeds = content.$1;
    List<Almanac> almanacs = content.$2;
    seeds.windowed(2, step: 2).toIterable();
    IntervalTree ranges = IntervalTree.from(seeds
        .windowed(2, step: 2)
        .map((e) => Interval(e.first, e.first + e.last - 1)));
    IntervalTree newRanges = IntervalTree();
    for (Almanac a in almanacs) {
      IntervalTree sourceTree = IntervalTree.from(
          a.boundaries.map((element) => Interval(element.$1, element.$2)));
      ranges = sourceTree.union(ranges).intersection(ranges);
      newRanges = IntervalTree.from(ranges.map((Interval e) =>
          Interval(a.destination(e.start), a.destination(e.end))));
      talker.info((ranges, sourceTree, newRanges));
      ranges = newRanges;
    }
    return newRanges.first.start;
  }
}
