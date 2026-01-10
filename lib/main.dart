import 'package:flutter/material.dart';
import 'presentation/views/welcome_screen.dart';
import 'presentation/views/mode_selection_screen.dart';
import 'presentation/temas/tema_general.dart';

void main() {
  runApp(const MyApp());
}

/// SymptoLeaf - Plant Disease Detection App
/// Added: Custom theme system with colors and typography
/// Updated: January 10, 2026
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SymptoLeaf',
      debugShowCheckedModeBanner: false,
      theme: TemaGeneral.lightTheme,
      home: const WelcomeScreen(),
      routes: {
        '/mode-selection': (context) => const ModeSelectionScreen(),
      },
    );
  }
}
