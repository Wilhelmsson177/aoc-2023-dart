import 'input.dart';

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
    print("-------------------------");
    print("         Day ${day.toString().padLeft(2, '0')}        ");
    print("Solution for puzzle one: ${solvePart1()}");
    print("Solution for puzzle two: ${solvePart2()}");
    print("\n");
  }
}