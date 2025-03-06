import 'dart:math';

/// Represents a line defined by two points or other mathematical properties.
class Line {
  final Point<num> start;
  final Point<num> end;

  /// Private constructor to enforce controlled creation through factory methods.
  const Line._(this.start, this.end);

  /// Creates a line from two points.
  factory Line.fromPoints(Point<num> start, Point<num> end) {
    return Line._(start, end);
  }

  /// Creates a line from slope and y-intercept.
  ///
  /// - [slope]: The slope of the line.
  /// - [yIntercept]: The y-intercept of the line (where it crosses the y-axis).
  factory Line.fromSlopeAndIntercept(num slope, num yIntercept, num rangeStart, num rangeEnd) {
    final start = Point<num>(rangeStart, slope * rangeStart + yIntercept);
    final end = Point<num>(rangeEnd, slope * rangeEnd + yIntercept);
    return Line._(start, end);
  }

  /// Creates a vertical line with a constant x-coordinate.
  factory Line.vertical(num x, num rangeStart, num rangeEnd) {
    return Line._(
      Point<num>(x, rangeStart),
      Point<num>(x, rangeEnd),
    );
  }

  /// Creates a horizontal line with a constant y-coordinate.
  factory Line.horizontal(num y, num rangeStart, num rangeEnd) {
    return Line._(
      Point<num>(rangeStart, y),
      Point<num>(rangeEnd, y),
    );
  }

  /// Creates a line from a string equation in the form "y = mx + b".
  ///
  /// Example input: "y = 2x + 3"
  factory Line.fromEquation(String equation, num rangeStart, num rangeEnd) {
    final match = RegExp(r'y\s*=\s*([+-]?\d*\.?\d*)x\s*([+-]\s*\d+\.?\d*)')
        .firstMatch(equation.replaceAll(' ', ''));

    if (match == null) {
      throw ArgumentError('Invalid equation format. Expected "y = mx + b".');
    }

    final slope = num.tryParse(match.group(1) ?? '1') ?? 1;
    final intercept = num.tryParse(match.group(2)!.replaceAll(' ', '')) ?? 0;

    return Line.fromSlopeAndIntercept(slope, intercept, rangeStart, rangeEnd);
  }

  factory Line.fromCenter({
    required Point<num> center,
    required num length,
    required num radians,
  }) {
    return Line._(
      center,
      Point<num>(
        center.x + (length * cos(radians)),
        center.y + (length * sin(radians)),
      ),
    );
  }

  @override
  String toString() => 'Line(start: $start, end: $end)';
}