import 'dart:async';
import 'dart:io';
import 'dart:core';

import 'package:dotenv/dotenv.dart';
import "package:args/args.dart";

import 'package:aoc/logger.dart';

/// Small Program to be used to generate files and boilerplate for a given day.\
/// Call with `dart run day_generator.dart <day>`
void main(List<String> args) async {
  var env = DotEnv(includePlatformEnvironment: true)
    ..load([".env", ".env.secrets"]);
  int year = int.parse(env.getOrElse("AOC_YEAR", () => "2019"));
  String session = env.getOrElse("AOC_SESSION", () => "");
  initializeLogging("debug");

  int dayOfMonth = DateTime.now().day;
  String exampleInput = "";
  int exampleExpectation = 0;
  bool onlyInputCreation = false;

  final parser = ArgParser();

  parser.addOption('day',
      abbr: 'd',
      defaultsTo: dayOfMonth.toString(),
      help: 'Select the day to execute',
      callback: (day) => dayOfMonth = int.parse(day!));

  parser.addOption('example-input',
      abbr: 'i',
      defaultsTo: '0',
      help: 'Add the example solution, so it will be put into the test.',
      callback: (input) => exampleInput = input!);

  parser.addOption('example-expectation',
      abbr: 'e',
      defaultsTo: '0',
      help: 'Add the example solution, so it will be put into the test.',
      callback: (input) => exampleExpectation = int.parse(input!));

  parser.addFlag('inputOnly',
      help: "Only download the input, but no further data.",
      callback: (p0) => onlyInputCreation = p0);

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

  ArgResults argResults = parser.parse(args);

  talker.debug("You have input the args ${argResults.arguments}");
  // Inform user which day will be generated
  talker.good(
      "Day $dayOfMonth will be generated.${onlyInputCreation ? ' (Just the input data)' : ''}");

  // Create input file
  await _downloadInputFile(year, dayOfMonth, session);

  if (!onlyInputCreation) {
    // Create lib file
    final dayFileName = 'day${dayOfMonth.toString().padLeft(2, '0')}.dart';
    unawaited(
      File('lib/solutions/$dayFileName').writeAsString(dayTemplate(dayOfMonth)),
    );
    // Create test file
    final dayTestFileName =
        'day${dayOfMonth.toString().padLeft(2, '0')}_test.dart';

    File('test/$dayTestFileName').writeAsStringSync(
        dayTestTemplate(dayOfMonth, exampleInput, exampleExpectation));

    final exportFile = File('lib/solutions/index.dart');
    final exports = exportFile.readAsLinesSync();
    String content =
        "export 'day${dayOfMonth.toString().padLeft(2, '0')}.dart';\n";
    bool found = false;
    // check if line already exists
    for (final line in exports) {
      if (line.contains('day${dayOfMonth.toString().padLeft(2, '0')}.dart')) {
        found = true;
        break;
      }
    }

    // export new day in index file if not present
    if (!found) {
      exportFile.writeAsString(
        content,
        mode: FileMode.append,
      );
    }

    addDayToMain(dayOfMonth);
  }
  talker.good('All set, Good luck!');
}

Future<void> _downloadInputFile(
    int year, int dayOfMonth, String session) async {
  // Create input file
  talker.good('Loading input from adventofcode.com...');
  try {
    final request = await HttpClient().getUrl(
        Uri.parse('https://adventofcode.com/$year/day/$dayOfMonth/input'));
    request.cookies.add(Cookie("session", session));
    final response = await request.close();
    final dataPath = 'input/${dayOfMonth.toString().padLeft(2, '0')}.in';
    response.pipe(File(dataPath).openWrite());
  } on Error catch (e) {
    talker.error('Error loading file: $e');
  }
}

void addDayToMain(int dayNumber) {
  File file = File('bin/aoc.dart');
  String dayString = dayNumber.toString().padLeft(2, '0');
  // Read the contents of the file
  String contents = file.readAsStringSync();

  if (contents.contains("Day$dayString(),")) {
    return;
  }
  String newContents = contents.replaceAll(
      '  //{add_me}', '  $dayNumber: Day$dayString(),\n  //{add_me}');

  file.writeAsStringSync(newContents);
}

String dayTemplate(int dayNumber) {
  String dayString = dayNumber.toString().padLeft(2, '0');
  return '''
import 'package:aoc/index.dart';

class Day$dayString extends GenericDay {
  final String inType;
  Day$dayString([this.inType='in']) : super($dayNumber, inType);

  @override
  List<int> parseInput() {
    final lines = input.getPerLine();
    // exemplary usage of ParseUtil class
    return ParseUtil.stringListToIntList(lines);
  }

  @override
  int solvePartA() {
    final input = parseInput();
    return 0;
  }

  @override
  int solvePartB() {
    // TODO implement
    return 0;
  }
}

''';
}

String dayTestTemplate(
    int dayNumber, String exampleInput, int exampleExpectation) {
  String dayString = dayNumber.toString().padLeft(2, '0');
  return '''
import 'package:aoc/logger.dart';
import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  initializeLogging("verbose");
  test('Day$dayString - Part A', () async {
    String input = """$exampleInput""";
    int expectation = $exampleExpectation;
    var day = Day$dayString(input);
    expect(day.solvePartA(), expectation);
  });

  test('Day$dayString - Part B', () async {
    String input = """$exampleInput""";
    int expectation = 0;
    var day = Day$dayString(input);
    expect(day.solvePartB(), expectation);
  });
}
''';
}
