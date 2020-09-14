import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ui/global/theme/app_themes.dart';
import '../ui/global/theme/bloc/theme_bloc.dart';

class PreferencePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: _buildThemeCards(context),
      ),
    );
  }

  List<Widget> _buildThemeCards(BuildContext context) {
    return AppTheme.values.map((itemAppTheme) {
      final currentTheme = appThemeData[itemAppTheme];
      return Card(
        color: currentTheme.primaryColor,
        child: ListTile(
          title: Text(
            '$itemAppTheme',
            style: currentTheme.textTheme.bodyText2,
          ),
          onTap: () {
            BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(
              theme: itemAppTheme,
            ));
          },
        ),
      );
    }).toList();
  }
}
