import 'package:flutter/material.dart';
import 'main.dart';         // Para usar SessionManager
import 'feed_screen.dart';  // Para que reconozca la pantalla InstaDamFeed

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores para capturar lo que el usuario escribe
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  // Estado del Checkbox "Recordar usuario"
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _checkSession(); // Al abrir el login, comprueba si ya entraste antes
  }

  // Lógica de SharedPreferences: si isLogged es true, salta el login automáticamente
  void _checkSession() async {
    if (await SessionManager.isLogged()) {
      _navigateToFeed();
    }
  }

  // Navegación segura: pushReplacement elimina la pantalla de login del historial
  void _navigateToFeed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => InstaDamFeed()),
    );
  }

  // Gestión del botón "Entrar" con validación de credenciales
  void _handleLogin() async {
    // 1. Extraemos el texto de los controladores
    String usuarioIngresado = _userController.text;
    String passwordIngresada = _passController.text;

    // 2. Validación: Comprobamos si coinciden con tus datos
    if (usuarioIngresado == "sergi" && passwordIngresada == "1234") {

      // Si son correctos, guardamos la sesión
      await SessionManager.saveSession(usuarioIngresado, _rememberMe);
      _navigateToFeed();

    } else {
      // 3. Si fallan o están vacíos, mostramos error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Usuario o contraseña incorrectos"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Limpieza de controladores para evitar que la app pete por memoria
  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("InstaDAM Login")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo de texto para el nombre de usuario
            TextField(
              controller: _userController,
              decoration: InputDecoration(
                labelText: "Usuario",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 10),
            // Campo de texto oculto para la contraseña
            TextField(
              controller: _passController,
              decoration: InputDecoration(
                labelText: "Contraseña",
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true, // Esto oculta los caracteres
            ),
            // Checkbox que gestiona la persistencia
            CheckboxListTile(
              title: Text("Recordar usuario"),
              value: _rememberMe,
              onChanged: (val) => setState(() => _rememberMe = val!),
            ),
            SizedBox(height: 20),
            // Botón que dispara la validación
            ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Botón ancho
              ),
              child: Text("Iniciar Sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
