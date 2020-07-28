import 'package:flutter/material.dart';

import '../slice_painter.dart';
import 'models/fruit.dart';
import 'models/fruit_part.dart';
import 'models/touch_slice.dart';

class CanvasArea extends StatefulWidget {
  @override
  _CanvasAreaState createState() => _CanvasAreaState();
}

class _CanvasAreaState extends State<CanvasArea> {
  TouchSlice touchSlice = TouchSlice();
  List<Fruit> fruits = [];
  List<FruitPart> fruitParts = [];

  @override
  void initState() {
    fruits.add(
      Fruit(
        position: Offset(0, 100),
        width: 80,
        height: 80,
        additionalForce: Offset(5, -10),
      ),
    );
    _tick();
    super.initState();
  }

  List<Widget> _getStack() {
    List<Widget> widgetsOnStack = [];
    widgetsOnStack.add(_getBackground());
    widgetsOnStack.add(_getSlice());
    widgetsOnStack.addAll(_getFruitParts());
    widgetsOnStack.addAll(_getFruits());
    widgetsOnStack.add(_getGestureDetector());

    return widgetsOnStack;
  }

  Widget _getSlice() {
    if (touchSlice.pointsList == null) return Container();
    return CustomPaint(
      painter: SlicePainter(pointsList: touchSlice.pointsList),
      size: Size.infinite,
    );
  }

  Widget _getGestureDetector() {
    return GestureDetector(
      onScaleStart: (details) {
        setState(() {
          touchSlice.start = details.localFocalPoint;
        });
      },
      onScaleUpdate: (details) {
        setState(() {
          _addPointsToSlice(details);
          _checkCollision();
        });
      },
      onScaleEnd: (_) {
        setState(() {
          touchSlice.reset();
        });
      },
    );
  }

  Widget _getBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color(0xFFFEB692),
            Color(0xFFEA5455),
          ],
          stops: [0.2, 1.0],
        ),
      ),
    );
  }

  List<Widget> _getFruits() {
    List<Widget> list = [];

    for (Fruit fruit in fruits) {
      list.add(
        Positioned(
          top: fruit.position.dy,
          left: fruit.position.dx,
          child: _getMelon(fruit),
        ),
      );
    }
    return list;
  }

  List<Widget> _getFruitParts() {
    //TODO Refactor
    List<Widget> list = [];

    for (FruitPart fruitPart in fruitParts) {
      list.add(
        Positioned(
          top: fruitPart.position.dy,
          left: fruitPart.position.dx,
          child: _getMelonPart(fruitPart),
        ),
      );
    }
    return list;
  }

  Widget _getMelon(Fruit fruit) {
    return Image.asset(
      'assets/slicey-03.png',
      height: 80,
      fit: BoxFit.fitHeight,
    );
  }

  Widget _getMelonPart(FruitPart fruitPart) {
    return Image.asset(
      fruitPart.isLeft ? 'assets/slicey-02.png' : 'assets/slicey-04.png',
      height: 80,
      fit: BoxFit.fitHeight,
    );
  }

  void _addPointsToSlice(ScaleUpdateDetails details) {
    if (touchSlice.pointsList.length > 16) touchSlice.pointsList.removeAt(0);
    touchSlice.update = details.localFocalPoint;
  }

  void _checkCollision() {
    if (touchSlice == null) return;

    for (Fruit fruit in List.from(fruits)) {
      bool isFirstPointOutside = false;
      bool isSecondPointInside = false;

      for (Offset point in touchSlice.pointsList) {
        if (!isFirstPointOutside && !fruit.isPointInside(point)) {
          isFirstPointOutside = true;
          continue;
        }

        if (isFirstPointOutside && fruit.isPointInside(point)) {
          isSecondPointInside = true;
          continue;
        }

        if (isSecondPointInside && !fruit.isPointInside(point)) {
          fruits.remove(fruit);
          _turnFruitIntoParts(fruit);
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _getStack(),
    );
  }

  void _turnFruitIntoParts(Fruit wholeFruit) {
    FruitPart leftFruitPart = FruitPart(
      position: Offset(
        wholeFruit.position.dx - wholeFruit.width * 0.075,
        wholeFruit.position.dy,
      ),
      width: wholeFruit.width,
      height: wholeFruit.height,
      isLeft: true,
      additionalForce: Offset(
        wholeFruit.additionalForce.dx - 1,
        wholeFruit.additionalForce.dy - 5,
      ),
    );

    FruitPart rightFruitPart = FruitPart(
      position: Offset(
        wholeFruit.position.dx + wholeFruit.width * 0.625,
        wholeFruit.position.dy,
      ),
      width: wholeFruit.width,
      height: wholeFruit.height,
      isLeft: false,
      additionalForce: Offset(
        wholeFruit.additionalForce.dx - 1,
        wholeFruit.additionalForce.dy - 5,
      ),
    );

    setState(() {
      fruitParts.add(leftFruitPart);
      fruitParts.add(rightFruitPart);
    });
  }

  void _tick() {
    setState(() {
      for (Fruit fruit in fruits) {
        fruit.applyGravity();
      }
      for (FruitPart fruitPart in fruitParts) {
        fruitPart.applyGravity();
      }

      Future.delayed(Duration(milliseconds: 30), _tick);
    });
  }
}
