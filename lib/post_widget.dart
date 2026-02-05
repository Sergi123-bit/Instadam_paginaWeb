import 'package:flutter/material.dart';
import 'post.dart'; // El modelo que creamos antes
import 'database_helper.dart'; // La base de datos real

class PostWidget extends StatefulWidget {
  final Post post;
  // Recibimos un objeto Post completo para mostrar sus datos
  PostWidget({required this.post});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLiked = false; // Estado local para el icono del corazón
  late int currentLikes; // Variable para manejar el contador visualmente

  @override
  void initState() {
    super.initState();
    // Inicializamos con los likes que ya vienen de la base de datos
    currentLikes = widget.post.likes;
  }

  // Método para dar/quitar like (Requisito: actualización inmediata en UI y DB)
  void toggleLike() async {
    setState(() {
      isLiked = !isLiked;
      // Lógica de incremento/decremento visual
      isLiked ? currentLikes++ : currentLikes--;
    });

    // Guardamos el cambio en SQFlite usando el ID del post
    // Usamos el DBHelper real importado, no el duplicado
    await DBHelper().updateLikes(widget.post.id!, currentLikes);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabecera del post con la inicial del usuario
          ListTile(
            leading: CircleAvatar(child: Text(widget.post.username[0].toUpperCase())),
            title: Text(widget.post.username, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(widget.post.date),
          ),
          // Imagen del post (Requisito: Placeholder si no hay imagen)
          Image.asset(
            widget.post.imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
            // Si la imagen falla o no existe, muestra un icono de error
            errorBuilder: (context, error, stackTrace) => Container(
                height: 300,
                color: Colors.grey[300],
                child: Icon(Icons.image, size: 100)
            ),
          ),
          // Barra de acciones (Likes y Comentarios)
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : null
                  ),
                  onPressed: toggleLike,
                ),
                Text('$currentLikes likes'),
                SizedBox(width: 15),
                Icon(Icons.chat_bubble_outline),
                // Requisito: Mostrar número de comentarios y botón para verlos
                Text(" ${widget.post.commentsCount} comentarios"),
              ],
            ),
          ),
          // Descripción de la publicación
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(widget.post.description),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
