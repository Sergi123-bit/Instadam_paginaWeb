import 'package:flutter/material.dart';

// Esta clase gestiona el estado global de la configuración
class SettingsProvider extends ChangeNotifier {
  // --- LÓGICA DE TEMA (MODO OSCURO/CLARO) ---
  ThemeMode _themeMode = ThemeMode.light; // Estado inicial: Claro

  ThemeMode get themeMode => _themeMode;

  // Cambia el tema y avisa a toda la app para que se repinte
  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // --- LÓGICA DE IDIOMA ---
  Locale _currentLocale = const Locale('es'); // Estado inicial: Español

  Locale get currentLocale => _currentLocale;

  // Cambia el idioma (ej: 'en' para inglés) y refresca la UI
  void changeLanguage(String languageCode) {
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }
}