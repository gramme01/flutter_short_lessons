import 'dart:ui';

abstract class GravitationalObject {
  Offset position;
  double gravitySpeed;
  double _gravity = 1.0;
  Offset additionalForce;
  double rotation;

  GravitationalObject({
    this.position,
    this.gravitySpeed = 0.0,
    this.additionalForce = const Offset(0, 0),
    this.rotation,
  });

  void applyGravity() {
    gravitySpeed += _gravity;
    position = Offset(
      position.dx + additionalForce.dx,
      position.dy + gravitySpeed + additionalForce.dy,
    );
  }
}
