import 'input.dart';
import 'package:timing/timing.dart';

typedef SolveFunction = int Function();
typedef SolutionWithDuration = (int result, Duration duration);

enum Part { a, b }

/// Provides the [InputUtil] for given day and a [getSolution] method to return
/// the puzzle solutions for given day and the duration.
abstract class GenericDay {
  final int day;
  final InputUtil input;
  final String inputType;

  GenericDay(this.day, [this.inputType = "in"])
      : input = InputUtil(day, inputType);

  dynamic parseInput();
  int solvePartA();
  int solvePartB();

  SolutionWithDuration getSoulution(Part part) {
    int result = -1;
    var tracker = SyncTimeTracker();
    SolveFunction func;
    if (part == Part.a) {
      func = solvePartA;
    } else {
      func = solvePartB;
    }
    tracker.track(() {
      result = func();
    });

    return (result, tracker.duration);
  }
}
