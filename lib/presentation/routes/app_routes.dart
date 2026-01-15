import 'package:flutter/material.dart';
import '../views/welcome_screen.dart';
import '../views/main_screen.dart';
import '../views/home_screen.dart';
import '../views/mode_selection_screen.dart';
import '../views/camera_screen.dart';
import '../views/result_screen.dart';
import '../views/chat_screen.dart';
import '../views/perfil_screen.dart';

/// App routes - Complete with all screens
/// Updated: January 15, 2026
class AppRoutes {
  static const String welcome = '/welcome';
  static const String main = '/';
  static const String home = '/home';
  static const String modeSelection = '/mode-selection';
  static const String camera = '/camera';
  static const String result = '/result';
  static const String chat = '/chat';
  static const String perfil = '/perfil';

  static Map<String, WidgetBuilder> get routes => {
    welcome: (context) => const WelcomeScreen(),
    main: (context) => const MainScreen(),
    home: (context) => const HomeScreen(),
    modeSelection: (context) => const ModeSelectionScreen(),
    camera: (context) => const CameraScreen(),
    result: (context) => const ResultScreen(),
    chat: (context) => const ChatScreen(),
    perfil: (context) => const PerfilScreen(),
  };
}
