import 'package:flutter/material.dart';

import 'second_page.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: const Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) {
              return SecondPage(
                transitionAnimation: animation,
              );
            },
          ));
        },
        child: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
