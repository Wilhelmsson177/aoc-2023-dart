import 'dart:core';
import 'dart:io';

import 'package:aoc_2023_dart/logger.dart';
import 'package:aoc_2023_dart/solutions/index.dart';
import 'package:aoc_2023_dart/generic_day.dart';
import 'package:args/args.dart';
import 'package:dart_console/dart_console.dart';

/// Map holding all the solution classes.
final List<GenericDay> dayList = [
  Day00(),
  //{add_me}
];
final Map<int, GenericDay> possibleDays = dayList.asMap();

void main(List<String> args) {
  int dayOfMonth = DateTime.now().day;
  final parser = ArgParser();
  bool allDays = false;

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

  parser.parse(args);

  Solver solver;
  if (allDays) {
    solver = Solver(possibleDays.keys.toList());
  } else {
    solver = Solver([dayOfMonth]);
  }
  solver.solve();
}

class Solver {
  final console = Console();
  final List<int> days;
  Map results = {};

  Solver(this.days);

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
      ({int duration, int result})? partA =
          possibleDays[index]?.getSoulutionA();
      progressBar.tick();
      ({int duration, int result})? partB =
          possibleDays[index]?.getSoulutionB();
      progressBar.tick();
      results[index] = (
        resultA: partA?.result,
        durationA: partA?.duration,
        resultB: partB?.result,
        durationB: partB?.duration
      );
    }

    progressBar.complete();
    console.writeLine();

    console.showCursor();
    console.writeLine();
  }

  void _printResults() {
    List<List<int>> solutions = List.empty(growable: true);
    for (var result in results.entries) {
      solutions.add([
        result.key,
        result.value.resultA,
        result.value.durationA,
        result.value.resultB,
        result.value.durationB
      ]);
    }
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
      ..title = 'The results of Advent of Code 2023';

    console.write(table);
  }
}
