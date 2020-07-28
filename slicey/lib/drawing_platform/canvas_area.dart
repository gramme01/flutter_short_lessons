import 'package:flutter/material.dart';

import '../slice_painter.dart';
import 'models/fruit.dart';
import 'models/touch_slice.dart';

class CanvasArea extends StatefulWidget {
  @override
  _CanvasAreaState createState() => _CanvasAreaState();
}

class _CanvasAreaState extends State<CanvasArea> {
  TouchSlice touchSlice = TouchSlice();
  List<Fruit> fruits = [];

  @override
  void initState() {
    fruits.add(
      Fruit(
        position: Offset(100, 100),
        width: 80,
        height: 80,
      ),
    );
    super.initState();
  }

  List<Widget> _getStack() {
    List<Widget> widgetsOnStack = [];
    widgetsOnStack.add(_getBackground());
    widgetsOnStack.add(_getSlice());
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
          child: Container(
            width: fruit.width,
            height: fruit.height,
            color: Colors.white,
          ),
        ),
      );
    }
    return list;
  }

  void _addPointsToSlice(ScaleUpdateDetails details) {
    if (touchSlice.pointsList.length > 16) touchSlice.pointsList.removeAt(0);
    touchSlice.update = details.localFocalPoint;
  }

  void _checkCollision() {
    if (touchSlice == null) return;
    for (Fruit fruit in List.from(fruits)) {
      for (Offset point in touchSlice.pointsList) {
        if (!fruit.isPointInside(point)) {
          continue;
        }
        fruits.remove(fruit);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _getStack(),
    );
  }
}
