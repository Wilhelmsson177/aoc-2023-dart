import 'input.dart';
import 'package:timing/timing.dart';

/// Provides the [InputUtil] for given day and a [printSolution] method to show
/// the puzzle solutions for given day.
abstract class GenericDay {
  final int day;
  final InputUtil input;
  final String inputType;

  GenericDay(this.day, [this.inputType = "in"])
      : input = InputUtil(day, inputType);

  dynamic parseInput();
  int solvePart1();
  int solvePart2();

  void printSolutions() {
    int resultPart1 = -1;
    int resultPart2 = -1;

    var trackerPart1 = SyncTimeTracker();
    var trackerPart2 = SyncTimeTracker();

    trackerPart1.track(() {
      resultPart1 = solvePart1();
    });
    trackerPart2.track(() {
      resultPart2 = solvePart2();
    });

    print("----------------------------------------------");
    print("         Day ${day.toString().padLeft(2, '0')}        ");
    print(
        "Solution for puzzle one: $resultPart1 (${trackerPart1.duration.inMilliseconds} ms)");
    print(
        "Solution for puzzle two: $resultPart2 (${trackerPart2.duration.inMilliseconds} ms)");
    print("\n");
  }
}
