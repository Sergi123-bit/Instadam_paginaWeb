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
/// Define la estructura principal de la interfaz mediante un [Scaffold].
return Scaffold(
  appBar: AppBar(
    /// Título con lógica de internacionalización (i18n). 
    /// Implementa una estructura condicional jerárquica para alternar entre 
    /// español, inglés y francés según el estado de [_currentLocale].
    title: Text(
      _currentLocale.languageCode == 'es' 
          ? "Mi Feed Espacial" 
          : _currentLocale.languageCode == 'en' 
              ? "Space Feed" 
              : "Flux Spatial"
    ),
    centerTitle: true,
    actions: [
      /// Menú desplegable para la selección dinámica de idioma.
      /// Permite al usuario conmutar la localización de la interfaz en tiempo real.
      PopupMenuButton<String>(
        icon: const Icon(Icons.language),
        onSelected: (String code) {
          // Invoca la lógica de cambio de idioma y actualización de estado.
          changeLanguage(code);
        },
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem(value: 'es', child: Text("Español")),
          const PopupMenuItem(value: 'en', child: Text("English")),
          const PopupMenuItem(value: 'fr', child: Text("Français")),
        ],
      ),
    ],
  ),
  // ... resto de tu body
);

//  GESTIÓN DE LOCALIZACIÓN (i18n) 

/// Almacena la configuración regional actual. Por defecto: Español.
Locale _currentLocale = const Locale('es');

/// Getter para exponer la configuración regional activa a la interfaz.
Locale get currentLocale => _currentLocale;

/// Actualiza la configuración regional del aplicativo.
/// [languageCode] debe ser un código ISO válido (ej: 'en', 'es', 'fr').
/// Llama a [notifyListeners] para propagar los cambios y reconstruir los widgets dependientes.
void changeLanguage(String languageCode) {
  _currentLocale = Locale(languageCode);
  notifyListeners(); // Dispara la reactividad del framework para actualizar los textos.
}
