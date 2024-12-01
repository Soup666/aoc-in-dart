import '../utils/index.dart';
import '../utils/math.dart';

class Hailstone extends Point {
  const Hailstone(super.x, super.y, super.z, super.velocity);

  /// Format [px py pz @ vx vy vz]
  factory Hailstone.fromString(String input) {
    final List<String> parts = input.split('@');

    final List<double> position =
        parts.first.split(',').map(double.parse).toList();
    final List<double> velocity =
        parts.last.split(',').map(double.parse).toList();

    return Hailstone(
      position[0],
      position[1],
      position[2],
      Vector(velocity[0], velocity[1], velocity[2]),
    );
  }
}

class Day24 extends GenericDay {
  Day24() : super(24);

  @override
  List<Hailstone> parseInput() =>
      input.getPerLine().map<Hailstone>(Hailstone.fromString).toList();

  @override
  int solvePart1() {
    // const int lBound = 200000000000000;
    // const int uBound = 400000000000000;

    // final parsedInput = parseInput();

    final a = Hailstone.fromString('19, 13, 30 @ -2, 1, -2');
    final b = Hailstone.fromString('18, 19, 22 @ -1, -1, -2');

    print('A: $a ${a.positionAt(5)}');
    print('B: $b ${b.positionAt(5)}');

    print('Intersection: ${a.intersection(b)}');
    return 0;
  }

  @override
  int solvePart2() {
    return 0;
  }
}
