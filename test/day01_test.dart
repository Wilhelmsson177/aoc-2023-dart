import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  test('Day01', () async {
    String input = "1abc2\npqr3stu8vwx\na1b2c3d4e5f\ntreb7uchet";
    int expectation = 142;
    var day = Day01(input);
    expect(day.solvePartA(), expectation);
  });

  test('Day01-B', () async {
    String input =
        "two1nine\neightwothree\nabcone2threexyz\nxtwone3four\n4nineeightseven2\nzoneight234\n7pqrstsixteen";
    int expectation = 281;
    var day = Day01(input);
    expect(day.solvePartB(), expectation);
  });
}
