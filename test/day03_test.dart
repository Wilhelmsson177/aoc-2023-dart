import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  test('Day03', () async {
    String input =
        "467..114..\n...*......\n..35..633.\n......#...\n617*......\n.....+.58.\n..592.....\n......755.\n...&.*....\n.664.598..";
    int expectation = 4361;
    var day = Day03(input);
    expect(day.solvePartA(), expectation);
    expect(day.solvePartB(), 467835);
  });
}
