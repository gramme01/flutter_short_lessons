import 'package:flutter/material.dart';

import '../preferences/preference_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PreferencePage(),
              ));
            },
          ),
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          child: Text(
            'Home Page',
            style: Theme.of(context).textTheme.headline4,
          )),
    );
  }
}
