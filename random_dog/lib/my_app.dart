import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dark_theme/dark_theme_provider.dart';
import 'home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: value.getTheme(),
          home: HomePage(),
        );
      },
    );
  }
}
