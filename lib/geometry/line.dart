part of library;

/// Represents a line defined by two points or other mathematical properties.
class Line {
  final Point<double> start;
  final Point<double> end;

  /// Private constructor to enforce controlled creation through factory methods.
  const Line._(this.start, this.end);

  /// Creates a line from two points.
  factory Line.fromPoints(Point<double> start, Point<double> end) {
    return Line._(start, end);
  }

  /// Creates a line from slope and y-intercept.
  ///
  /// - [slope]: The slope of the line.
  /// - [yIntercept]: The y-intercept of the line (where it crosses the y-axis).
  factory Line.fromSlopeAndIntercept(double slope, double yIntercept, double rangeStart, double rangeEnd) {
    final start = Point<double>(rangeStart, slope * rangeStart + yIntercept);
    final end = Point<double>(rangeEnd, slope * rangeEnd + yIntercept);
    return Line._(start, end);
  }

  /// Creates a vertical line with a constant x-coordinate.
  factory Line.vertical(double x, double rangeStart, double rangeEnd) {
    return Line._(
      Point<double>(x, rangeStart),
      Point<double>(x, rangeEnd),
    );
  }

  /// Creates a horizontal line with a constant y-coordinate.
  factory Line.horizontal(double y, double rangeStart, double rangeEnd) {
    return Line._(
      Point<double>(rangeStart, y),
      Point<double>(rangeEnd, y),
    );
  }

  /// Creates a line from a string equation in the form "y = mx + b".
  ///
  /// Example input: "y = 2x + 3"
  factory Line.fromEquation(String equation, double rangeStart, double rangeEnd) {
    final match = RegExp(r'y\s*=\s*([+-]?\d*\.?\d*)x\s*([+-]\s*\d+\.?\d*)')
        .firstMatch(equation.replaceAll(' ', ''));

    if (match == null) {
      throw ArgumentError('Invalid equation format. Expected "y = mx + b".');
    }

    final slope = double.tryParse(match.group(1) ?? '1') ?? 1;
    final intercept = double.tryParse(match.group(2)!.replaceAll(' ', '')) ?? 0;

    return Line.fromSlopeAndIntercept(slope, intercept, rangeStart, rangeEnd);
  }

  factory Line.fromCenter({
    required Point<double> center,
    required double length,
    required double radians,
  }) {
    return Line._(
      center,
      Point<double>(
        center.x + (length * cos(radians)),
        center.y + (length * sin(radians)),
      ),
    );
  }

  @override
  String toString() => 'Line(start: $start, end: $end)';
}