import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final Animation<double> transitionAnimation;

  const SecondPage({
    Key key,
    this.transitionAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: AnimatedBuilder(
              animation: transitionAnimation,
              builder: (context, child) {
                return SlideTransition(
                  position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
                      .animate(
                    CurvedAnimation(
                      curve: Interval(0, 0.5, curve: Curves.easeOutCubic),
                      parent: transitionAnimation,
                    ),
                  ),
                  child: child,
                );
              },
              child: Container(
                color: Colors.red,
              ),
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: transitionAnimation,
              builder: (context, child) {
                return SlideTransition(
                  position:
                      Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
                          .animate(
                    CurvedAnimation(
                      curve: Interval(0.5, 1.0, curve: Curves.easeOutCubic),
                      parent: transitionAnimation,
                    ),
                  ),
                  child: child,
                );
              },
              child: Container(
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop();
        },
        label: Text('Navigate Back'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
