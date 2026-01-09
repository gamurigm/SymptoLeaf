import 'package:flutter/material.dart';
import 'presentation/views/welcome_screen.dart';
import 'presentation/views/mode_selection_screen.dart';

void main() {
  runApp(const MyApp());
}

/// SymptoLeaf - Plant Disease Detection App
/// Added: Welcome screen with animations
/// Updated: January 9, 2026
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SymptoLeaf',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
      routes: {
        '/mode-selection': (context) => const ModeSelectionScreen(),
      },
    );
  }
}
