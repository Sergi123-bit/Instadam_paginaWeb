import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_helper.dart'; // Importante para acceder a la lógica de SQFlite
import 'post.dart';

// Definimos la pantalla de Perfil como un StatefulWidget porque los datos (nombre y contador) cambiarán al cargar
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Variables de estado iniciales
  String userName = "Cargando...";
  int postCount = 0;

  // El ciclo de vida initState se ejecuta una sola vez al insertar el widget en el árbol
  @override
  void initState() {
    super.initState();
    _loadProfile(); // Disparamos la carga de datos persistentes
  }

  // Método asíncrono para recuperar datos de ambos sistemas de persistencia
  void _loadProfile() async {
    // 1. Uso de SharedPreferences: Recuperamos el nombre del usuario logueado
    final prefs = await SharedPreferences.getInstance();
    String savedName = prefs.getString("userName") ?? "Usuario";

    // 2. Uso de SQFlite: Consultamos a la base de datos cuántos posts existen para este nombre
    int count = await DBHelper().getUserPostCount(savedName);

    // Actualizamos el estado para que Flutter repinte la interfaz con los datos reales
    setState(() {
      userName = savedName;
      postCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Perfil")),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Avatar genérico para el perfil
          CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          SizedBox(height: 10),
          // Muestra el nombre recuperado de SharedPreferences
          Text(userName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

          // GestureDetector permite hacer clic en el contador para cumplir el requisito de la actividad
          GestureDetector(
            onTap: () {
              // Acción futura: Navegar al feed filtrado por usuario
              print("Ver posts de $userName");
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  // Muestra la cantidad de posts calculada desde SQFlite
                  Text("$postCount", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("Publicaciones", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          Divider(), // Línea divisoria visual
        ],
      ),
    );
  }
}

// Clase de utilidad independiente para gestionar configuraciones globales (Requisito técnico)
class SettingsManager {
  // Claves constantes para evitar errores de escritura
  static const String keyDarkMode = "darkMode";
  static const String keyNotifications = "notifications";
  static const String keyLanguage = "language";

  // Método para persistir la preferencia de tema (Modo Oscuro)
  static Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyDarkMode, value);
  }

  // Método para persistir el idioma seleccionado
  static Future<void> setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyLanguage, lang);
  }

  // Recupera el estado actual del modo oscuro (por defecto falso/claro)
  static Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyDarkMode) ?? false;
  }
}