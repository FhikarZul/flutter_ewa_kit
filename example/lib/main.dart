import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter/material.dart';

import 'demo/demo_screen.dart';

void main() async {
  await EwaKit.initialize(() {
    runApp(const EwaKitExampleApp());
  });
}

class EwaKitExampleApp extends StatefulWidget {
  const EwaKitExampleApp({super.key});

  @override
  State<EwaKitExampleApp> createState() => _EwaKitExampleAppState();
}

class _EwaKitExampleAppState extends State<EwaKitExampleApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else if (_themeMode == ThemeMode.dark) {
        _themeMode = ThemeMode.system;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return EwaApp(
      child: MaterialApp(
        title: 'EWA Kit Example',
        theme: EwaTheme.light(),
        darkTheme: EwaTheme.dark(),
        themeMode: _themeMode,
        home: DemoScreen(onThemeToggle: _toggleTheme),
      ),
    );
  }
}
