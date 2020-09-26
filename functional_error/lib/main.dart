import 'package:flutter/material.dart';
import 'package:functional_error/post_change_notifier.dart';
import 'package:provider/provider.dart';

import 'post_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: ChangeNotifierProvider(
        create: (_) => PostChangeNotifier(),
        child: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error Handling'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Consumer<PostChangeNotifier>(
              builder: (_, notifier, __) {
                if (notifier.state == NotifierState.initial) {
                  return StyledText('Press the button 👇');
                } else if (notifier.state == NotifierState.loading) {
                  return CircularProgressIndicator();
                } else {
                  return notifier.post.fold(
                      (failure) => StyledText(failure.toString()),
                      (post) => StyledText(post.toString()));
                }
              },
            ),
            RaisedButton(
              child: Text('Get Post'),
              onPressed: () async {
                Provider.of<PostChangeNotifier>(context, listen: false)
                    .getOnePost();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StyledText extends StatelessWidget {
  const StyledText(
    this.text, {
    Key key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 40),
    );
  }
}
