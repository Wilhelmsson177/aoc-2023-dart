import 'dart:core';
import 'dart:io';
import 'package:dotenv/dotenv.dart';
import 'package:aoc/logger.dart';
import 'package:aoc/solutions/index.dart';
import 'package:aoc/generic_day.dart';
import 'package:args/args.dart';
import 'package:dart_console/dart_console.dart';

/// Map holding all the solution classes.
final Map<int, GenericDay> possibleDays = {
  0: Day00(),
  1: Day01(),
  2: Day02(),
  3: Day03(),
  4: Day04(),
  5: Day05(),
  6: Day06(),
  7: Day07(),
  8: Day08(),
  9: Day09(),
  11: Day11(),
  10: Day10(),
  15: Day15(),
  16: Day16(),
  18: Day18(),
  21: Day21(),
  //{add_me}
};

void main(List<String> args) {
  var env = DotEnv(includePlatformEnvironment: true)..load();
  int year = int.parse(env.getOrElse("AOC_YEAR", () => "2023"));
  int dayOfMonth = DateTime.now().day;
  final parser = ArgParser();
  bool allDays = false;

  parser.addOption("loglevel",
      abbr: "l",
      defaultsTo: "info",
      help: "Set the log level of the application", callback: (logLevel) {
    initializeLogging(logLevel!);
  });

  parser.addFlag(
    'help',
    abbr: 'h',
    negatable: false,
    help: 'Show this help dialog.',
    callback: (help) {
      if (help) {
        print(parser.usage);
        exit(0);
      }
    },
  );

  parser.addFlag('all',
      abbr: 'a',
      negatable: false,
      help: 'Executes all days',
      callback: (input) => allDays = input);

  parser.addOption('day',
      abbr: 'd',
      defaultsTo: dayOfMonth.toString(),
      help: 'Select the day to execute', callback: (day) {
    int parsedDay = int.parse(day!);
    if (possibleDays.containsKey(parsedDay)) {
      dayOfMonth = parsedDay;
    } else if (!allDays) {
      talker
          .error("The selected day ($parsedDay) is not available for solving!");
      exit(1);
    }
  });

  parser.parse(args);

  Solver solver;
  if (allDays) {
    solver = Solver(possibleDays.keys.toList(), year);
  } else {
    solver = Solver([dayOfMonth], year);
  }
  solver.solve();
}

typedef SolutionsOfDay = (SolutionWithDuration, SolutionWithDuration);

class Solver {
  final console = Console();
  final List<int> days;
  final int year;
  Map<int, SolutionsOfDay> results = {};

  Solver(this.days, this.year);

  void solve() {
    _printIntroduction();
    _doTheMath();
    _printResults();
  }

  void _printIntroduction() {
    Calendar calendar = Calendar.now();
    calendar.title = "Today is";
    console.writeLine();
    console.writeAligned(calendar.toString(), 76, TextAlignment.center);
    console.writeLine();
  }

  void _doTheMath() {
    console.writeAligned('S O L V I N G', 76, TextAlignment.center);
    console.writeLine();
    console.writeAligned(
        'Please wait while we do the math...', 76, TextAlignment.center);
    console.writeLine();
    console.hideCursor();

    final progressBar = ProgressBar(
      maxValue: days.length * 2,
      barWidth: 76,
      showSpinner: true,
      tickCharacters: ['#'],
    );

    for (int index in days) {
      SolutionWithDuration partA = possibleDays[index]!.getSoulution(Part.a);
      progressBar.tick();
      SolutionWithDuration partB = possibleDays[index]!.getSoulution(Part.b);
      progressBar.tick();
      results[index] = (partA, partB);
    }

    progressBar.complete();
    console.writeLine();

    console.showCursor();
    console.writeLine();
  }

  void _printResults() {
    List<List<Object>> solutions = List.empty(growable: true);
    Duration timingPartA = Duration();
    Duration timingPartB = Duration();
    for (var result in results.entries) {
      timingPartA += result.value.$1.$2;
      timingPartB += result.value.$2.$2;
      solutions.add([
        result.key,
        result.value.$1.$1,
        result.value.$1.$2.toString(),
        result.value.$2.$1,
        result.value.$2.$2.toString()
      ]);
    }
    List<Object> calculatedTiming = [
      "Overall timing",
      "",
      timingPartA.toString(),
      "",
      timingPartB.toString()
    ];

    final table = Table()
      ..borderColor = ConsoleColor.blue
      ..borderStyle = BorderStyle.rounded
      ..borderType = BorderType.horizontal
      ..insertColumn(header: 'Day', alignment: TextAlignment.center)
      ..insertColumn(header: 'Solution Part A', alignment: TextAlignment.right)
      ..insertColumn(header: 'Timing Part A', alignment: TextAlignment.right)
      ..insertColumn(header: 'Solution Part B', alignment: TextAlignment.right)
      ..insertColumn(header: 'Timing Part B', alignment: TextAlignment.right)
      ..insertRows(solutions)
      ..insertRow(calculatedTiming)
      ..title = 'The results of Advent of Code $year';

    console.write(table);
  }
}
