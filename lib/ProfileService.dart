import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  // Guardar nombre y ruta de foto de perfil
  static Future<void> saveProfileData(String name, String? photoPath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    if (photoPath != null) await prefs.setString('profilePhoto', photoPath);
  }

  // Obtener datos del perfil
  static Future<Map<String, String?>> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('userName') ?? 'Usuario',
      'photo': prefs.getString('profilePhoto'),
    };
  }
}