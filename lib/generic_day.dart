import 'input.dart';
import 'package:timing/timing.dart';

/// Provides the [InputUtil] for given day and a [getSolutionX] method to return
/// the puzzle solutions for given day and the duration.
abstract class GenericDay {
  final int day;
  final InputUtil input;
  final String inputType;

  GenericDay(this.day, [this.inputType = "in"])
      : input = InputUtil(day, inputType);

  dynamic parseInput();
  int solvePart1();
  int solvePart2();

  ({int result, int duration}) getSoulutionA() {
    int result = -1;
    var tracker = SyncTimeTracker();

    tracker.track(() {
      result = solvePart1();
    });

    return (result: result, duration: tracker.duration.inMilliseconds);
  }

  ({int result, int duration}) getSoulutionB() {
    int result = -1;
    var tracker = SyncTimeTracker();

    tracker.track(() {
      result = solvePart2();
    });

    return (result: result, duration: tracker.duration.inMilliseconds);
  }
}
