import 'package:flutter/material.dart';
import 'package:slicey/slice_painter.dart';
import '../models/touch_slice.dart';

class CanvasArea extends StatefulWidget {
  @override
  _CanvasAreaState createState() => _CanvasAreaState();
}

class _CanvasAreaState extends State<CanvasArea> {
  TouchSlice touchSlice = TouchSlice();

  List<Widget> _getStack() {
    List<Widget> widgetsOnStack = [];

    widgetsOnStack.add(_getSlice());
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
        });
      },
      onScaleEnd: (_) {
        setState(() {
          touchSlice.reset();
        });
      },
    );
  }

  void _addPointsToSlice(ScaleUpdateDetails details) {
    touchSlice.update = details.localFocalPoint;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _getStack(),
    );
  }
}
