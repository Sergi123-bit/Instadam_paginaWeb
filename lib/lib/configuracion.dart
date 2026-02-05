import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  // --- MODO OSCURO / CLARO ---
  // Por defecto empezamos en modo claro
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  // Función para alternar entre temas
  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Esto avisa a la app que debe redibujarse
  }

  // --- IDIOMA ---
  // Por defecto en español
  Locale _currentLocale = const Locale('es');

  Locale get currentLocale => _currentLocale;

  // Función para cambiar el idioma (ej: 'en' para inglés, 'es' para español)
  void changeLanguage(String languageCode) {
    _currentLocale = Locale(languageCode);
    notifyListeners(); // Esto actualiza los textos de la app
  }
}