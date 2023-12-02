import 'package:aoc/index.dart';
import 'package:dartx/dartx.dart';

enum Color {
  blue,
  red,
  green;

  static Color getByValue(String color) {
    return switch (color) {
      "blue" => Color.blue,
      "red" => Color.red,
      "green" => Color.green,
      _ => throw Error(),
    };
  }
}

class ColorCounts {
  int red;
  int blue;
  int green;
  ColorCounts(this.red, this.green, this.blue);
}

typedef Game = (int, List<ColorCounts>);

class Day02 extends GenericDay {
  final String inType;
  Day02([this.inType = 'in']) : super(2, inType);

  @override
  List<Game> parseInput() {
    final lines = input.getPerLine();
    List<Game> games = [];
    for (String line in lines) {
      int id = line.split(":").first.trim().split(" ").last.toInt();
      List<ColorCounts> cc = [];
      for (String draw in line.split(":").last.split(";")) {
        int red = 0;
        int green = 0;
        int blue = 0;
        for (String colorCount in draw.split(",")) {
          var counts = colorCount.trim().split(" ");
          switch (counts.last) {
            case "red":
              red = counts.first.toInt();
              break;
            case "green":
              green = counts.first.toInt();
              break;
            case "blue":
              blue = counts.first.toInt();
              break;
            default:
          }
        }
        cc.add(ColorCounts(red, green, blue));
      }
      games.add((id, cc));
    }
    return games;
  }

  @override
  int solvePartA() {
    int sum = 0;
    for (Game game in parseInput()) {
      List<ColorCounts> cc = game.$2;
      if (cc.all((element) =>
          (element.blue <= 14) & (element.red <= 12) & (element.green <= 13))) {
        sum += game.$1;
      }
    }
    return sum;
  }

  @override
  int solvePartB() {
    int sum = 0;
    for (Game game in parseInput()) {
      List<ColorCounts> cc = game.$2;
      int maxRed = max(cc.map((e) => e.red).toList())!;
      int maxGreen = max(cc.map((e) => e.green).toList())!;
      int maxBlue = max(cc.map((e) => e.blue).toList())!;
      int power = maxRed * maxBlue * maxGreen;
      sum += power;
    }
    return sum;
  }
}
