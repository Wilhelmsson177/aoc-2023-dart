import 'dart:async';
import 'dart:io';
import 'dart:core';

import 'package:dotenv/dotenv.dart';
import "package:args/args.dart";

import 'package:aoc_2023_dart/logger.dart';

/// Small Program to be used to generate files and boilerplate for a given day.\
/// Call with `dart run day_generator.dart <day>`
void main(List<String> args) async {
  var env = DotEnv(includePlatformEnvironment: true)..load();
  String year = env.getOrElse("AOC_YEAR", () => "2022");
  String session = env.getOrElse("AOC_SESSION", () => "");

  int dayOfMonth = DateTime.now().day;
  int exampleValue = 0;

  final parser = ArgParser();

  parser.addOption('day',
      abbr: 'd',
      defaultsTo: dayOfMonth.toString(),
      help: 'Select the day to execute',
      callback: (day) => dayOfMonth = int.parse(day!));

  parser.addOption('example',
      abbr: 'e',
      defaultsTo: '0',
      help: 'Add the example solution, so it will be put into the test.',
      callback: (input) => dayOfMonth = int.parse(input!));

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
  talker.good("Day $dayOfMonth will be generated.");

  // Create lib file
  final dayFileName = 'day${dayOfMonth.toString().padLeft(2, '0')}.dart';
  unawaited(
    File('lib/solutions/$dayFileName')
        .writeAsString(dayTemplate(dayOfMonth, year)),
  );
  // Create test file
  final dayTestFileName =
      'test_day${dayOfMonth.toString().padLeft(2, '0')}.dart';

  File('test/$dayTestFileName')
      .writeAsStringSync(dayTestTemplate(dayOfMonth, year));

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

  // Create input file
  await _downloadInputFile(year, dayOfMonth, session);

  // Create an example file
  _createExampleFile(dayOfMonth, exampleValue);

  talker.good('All set, Good luck!');
}

Future<void> _downloadInputFile(
    String year, int dayOfMonth, String session) async {
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
    talker.error('Error loading file:', e);
  }
}

void _createExampleFile(int dayOfMonth, int exampleValue) {
  // Create an example file
  final examplePath =
      File('input/${dayOfMonth.toString().padLeft(2, '0')}.example');
  examplePath.writeAsStringSync(exampleValue.toString());
}

void addDayToMain(int dayNumber) {
  File file = File('bin/aoc_2023_dart.dart');
  String dayString = dayNumber.toString().padLeft(2, '0');
  // Read the contents of the file
  String contents = file.readAsStringSync();

  if (contents.contains("Day$dayString(),")) {
    return;
  }
  String newContents =
      contents.replaceAll('  //{add_me}', ' Day$dayString(),\n  //{add_me}');

  file.writeAsStringSync(newContents);
}

String dayTemplate(int dayNumber, String year) {
  String dayString = dayNumber.toString().padLeft(2, '0');
  return '''
import 'package:aoc_${year}_dart/index.dart';

class Day$dayString extends GenericDay {
  final String inType;
  Day$dayString([this.inType='in']) : super($dayNumber, inType);

  @override
  parseInput() {

  }

  @override
  int solvePart1() {
    // TODO implement
    return 0;
  }

  @override
  int solvePart2() {
    // TODO implement
    return 0;
  }
}

''';
}

String dayTestTemplate(int dayNumber, String year) {
  String dayString = dayNumber.toString().padLeft(2, '0');
  return '''
import 'package:test/test.dart';
import 'package:aoc_${year}_dart/solutions/index.dart';

void main() {
  test('Day$dayString', () async {
    var day = Day$dayString("example");
    expect(day.solvePart1(), 0);
    expect(day.solvePart2(), 0);
  });
}
''';
}
