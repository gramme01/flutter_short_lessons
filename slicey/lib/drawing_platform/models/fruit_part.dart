import 'dart:ui';

import 'package:meta/meta.dart';
import 'gravitational_object.dart';

class FruitPart extends GravitationalObject {
  // Offset position;
  double width, height;
  bool isLeft;

  FruitPart({
    position,
    @required this.width,
    @required this.height,
    @required this.isLeft,
    gravitySpeed = 0.0,
    additionalForce = const Offset(0, 0),
    rotation = 0.0,
  }) : super(
          position: position,
          gravitySpeed: gravitySpeed,
          additionalForce: additionalForce,
          rotation: rotation,
        );
}
