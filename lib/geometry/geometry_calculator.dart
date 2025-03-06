import 'dart:math';

import 'line.dart';

/// Geometry utilities class for point transformations and calculations.
class GeometryCalculator {
  GeometryCalculator._();

  /// Calculates the mirror points of a given set of points relative to a specified line.
  ///
  /// - [points]: The set of points to be mirrored.
  /// - [line]: The line relative to which the points are mirrored.
  /// Returns: An iterable containing the mirrored points.
  static Iterable<Point<num>> calculateMirrorPoints({
    required Iterable<Point<num>> points,
    required Line line,
  }) {
    final num a = line.start.y - line.end.y;
    final num b = -(line.start.x - line.end.x);
    final num c = line.start.x * line.end.y - line.end.x * line.start.y;

    final num denominator = a * a + b * b;

    return points.map((point) {
      final num factor = -2 * (a * point.x + b * point.y + c) / denominator;
      return Point(
        factor * a + point.x,
        factor * b + point.y,
      );
    });
  }

  /// Calculates the cumulative positions of a sequence of points.
  ///
  /// - [points]: The collection of points to calculate cumulative positions for.
  /// Returns: A new collection of points where each point's position is the cumulative
  ///          sum relative to the previous points.
  static Iterable<Point<T>> calculateCumulativePositions<T extends num>({
    required Iterable<Point<T>> points,
  }) sync* {
    if (points.isEmpty) return;
    var cumulativePoint = Point<T>(0 as T, 0 as T);
    for (final point in points) {
      cumulativePoint = Point(
        (cumulativePoint.x + point.x) as T,
        (cumulativePoint.y + point.y) as T,
      );
      yield cumulativePoint;
    }
  }

}
