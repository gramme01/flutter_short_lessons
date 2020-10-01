import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'second_page.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1000),
            pageBuilder: (context, animation, secondaryAnimation) {
              return ListenableProvider(
                create: (context) => animation,
                child: SecondPage(),
              );
              // return SecondPage();
            },
          ));
        },
        child: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
