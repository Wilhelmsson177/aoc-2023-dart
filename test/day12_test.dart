import 'package:test/test.dart';
import 'package:aoc/solutions/index.dart';

void main() {
  test('Day12 - input test', () async {
    String unknown = """???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1""";
    int expectation = 21;
    var day = Day12(unknown);
    expect(day.solvePartA(), expectation);
  });

  test('Day12 - known test', () async {
    String known = """#.#.### 1,1,3
.#...#....###. 1,1,3
.#.###.#.###### 1,3,1,6
####.#...#... 4,1,1
#....######..#####. 1,6,5
.###.##....# 3,2,1""";
    int expectation = 21;
    var day = Day12(known);
    expect(day.solvePartA(), expectation);
  });
}
