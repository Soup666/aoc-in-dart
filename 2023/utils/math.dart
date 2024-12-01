import 'package:equatable/equatable.dart';

class Vector extends Equatable {
  const Vector(this.x, this.y, this.z);
  final double x;
  final double y;
  final double z;

  Vector operator +(Vector other) =>
      Vector(x + other.x, y + other.y, z + other.z);
  Vector operator *(double scalar) =>
      Vector(x * scalar, y * scalar, z * scalar);

  double get slopeRatio => x / y;

  @override
  String toString() => '($x, $y, $z)';

  @override
  List<Object?> get props => [x, y, z];
}

class Point extends Vector {
  const Point(super.x, super.y, super.z, this.velocity);

  final Vector velocity;

  Vector positionAt(double t) => this + (velocity * t);

  /// [s, t] = 1/(m_x_1 * -m_y_2 + m_x_2 * m_y_1) * [(b_x_1 - b_x_2), (b_y_1, b_y_2)]
  Vector intersection(Point other) {
    final a =
        1 / (velocity.x * -other.velocity.y + other.velocity.x * velocity.y);
    final Vector scalar = Vector(x - other.x, y - other.y, z - other.z);

    final intersects = scalar * a;
    return positionAt(intersects.x);
  }

  @override
  String toString() => '($x, $y, $z) @ $velocity';
}
