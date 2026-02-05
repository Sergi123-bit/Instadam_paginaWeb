import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'feed_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Necesario cuando usas async antes de runApp (por ejemplo SharedPreferences)

  bool loggedIn = await SessionManager.isLogged();
  // Consultamos si el usuario ya tiene sesión guardada

  runApp(InstaDAMApp(isLoggedIn: loggedIn));
  // Lanzamos la app indicando si debe ir al feed o al login
}

class InstaDAMApp extends StatelessWidget {
  final bool isLoggedIn;
  const InstaDAMApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      // Si hay sesión guardada → Feed, si no → Login
      home: isLoggedIn ? InstaDamFeed() : LoginPage(),
    );
  }
}

// Gestión de sesión con SharedPreferences
class SessionManager {
  static const String keyLoggedIn = "isLoggedIn";
  static const String keyUserName = "userName";

  static Future<void> saveSession(String name, bool remember) async {
    final prefs = await SharedPreferences.getInstance();

    // Solo guardamos si el usuario marcó "Recordarme"
    if (remember) {
      await prefs.setBool(keyLoggedIn, true);
      await prefs.setString(keyUserName, name);
    }
  }

  static Future<bool> isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    // Si no existe, devolvemos false
    return prefs.getBool(keyLoggedIn) ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // Limpia toda la sesión (incluye nombre y estado de login)
  }
}
