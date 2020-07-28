import 'dart:ui';

import 'package:meta/meta.dart';

import 'gravitational_object.dart';

class Fruit extends GravitationalObject {
  // Offset position;
  double width, height;

  Fruit({
    position,
    @required this.width,
    @required this.height,
    gravitySpeed = 0.0,
    additionalForce = const Offset(0, 0),
    rotation = 0.0,
  }) : super(
          position: position,
          gravitySpeed: gravitySpeed,
          additionalForce: additionalForce,
          rotation: rotation,
        );

  bool isPointInside(Offset point) {
    if (point.dx < position.dx) return false;
    if (point.dx > position.dx + width) return false;
    if (point.dy < position.dy) return false;
    if (point.dy > position.dy + height) return false;
    return true;
  }
}
