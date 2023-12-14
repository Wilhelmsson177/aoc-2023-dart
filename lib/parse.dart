class ParseUtil {
  /// Throws an exception if any given String is not parseable.
  static List<int> stringListToIntList(List<String> strings) {
    return strings.map(int.parse).toList();
  }

  /// Returns decimal number from binary string
  static int binaryToDecimal(String binary) {
    return int.parse(binary, radix: 2);
  }

  static List<List<String>> blockToFieldLike(String block) {
    return block
        .split(RegExp(r'\n'))
        .map((element) => element.split(""))
        .toList();
  }
}
