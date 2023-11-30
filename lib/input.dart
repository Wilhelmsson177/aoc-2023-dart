import 'dart:io';

/// Automatically reads reads the contents of the input file for given [day]. \
/// Note that file name and location must align.
class InputUtil {
  late final String _inputAsString;
  late final List<String> _inputAsList;
  final int day;
  final String inputType;

  InputUtil(this.day, [this.inputType = "in"]) {
    if (inputType == "in") {
      _inputAsString = _readInputDay();
      _inputAsList = _readInputDayAsList();
    } else {
      _inputAsString = inputType;
      _inputAsList = inputType.split("\n");
    }
  }

  String _createInputPath() {
    String dayString = day.toString().padLeft(2, '0');
    return './input/$dayString.$inputType';
  }

  String _readInputDay() {
    return _readInput(_createInputPath());
  }

  String _readInput(String input) {
    return File(input).readAsStringSync();
  }

  List<String> _readInputDayAsList() {
    return _readInputAsList(_createInputPath());
  }

  List<String> _readInputAsList(String input) {
    return File(input).readAsLinesSync();
  }

  /// Returns input as one String.
  String get asString => _inputAsString;

  /// Reads the entire input contents as lines of text.
  List<String> getPerLine() => _inputAsList;

  /// Splits the input String by `whitespace` and `newline`.
  List<String> getPerWhitespace() {
    return _inputAsString.split(RegExp(r'\s\n'));
  }

  /// Splits the input String by given pattern.
  List<String> getBy(String pattern) {
    return _inputAsString.split(pattern);
  }
}
