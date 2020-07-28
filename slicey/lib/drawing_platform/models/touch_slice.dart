import 'dart:ui';

class TouchSlice {
  List<Offset> _pointsList;
  TouchSlice([this._pointsList]);

  TouchSlice.start(Offset point) {
    _pointsList = [point];
  }

  List<Offset> get pointsList => _pointsList;

  set start(Offset point) {
    this._pointsList = [point];
  }

  set update(Offset point) {
    this._pointsList.add(point);
  }

  void reset() {
    this._pointsList = null;
  }

  @override
  String toString() => 'TouchSlice(pointsList: $_pointsList)';
}
