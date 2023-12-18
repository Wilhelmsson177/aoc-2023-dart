import 'package:aoc/field.dart';

enum Direction { west, east, south, north }

int calculatePolygonArea(List<Position> points) {
  // Calculate the shoelace sum
  int area = 0;
  for (int i = 0; i < points.length; i++) {
    int j = (i + 1) % points.length;
    int xi = points[i].x, yi = points[i].y;
    int xj = points[j].x, yj = points[j].y;
    int crossProduct = (xi * yj) - (xj * yi);
    area += crossProduct;
  }

  // Normalize the area by dividing by two
  return (area / 2).floor();
}
