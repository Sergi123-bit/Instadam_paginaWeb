import 'package:flutter/material.dart';
import 'lib/configuracion.dart';
import 'settings_provider.dart';

class InstaDamFeed extends StatefulWidget {
  @override
  _InstaDamFeedState createState() => _InstaDamFeedState();
}

class _InstaDamFeedState extends State<InstaDamFeed> {
  // 1. LISTA DE IMÁGENES: Nombres exactos de tus archivos locales
  final List<String> misImagenes = [
    'assets/images.jpg',
    'assets/descarga (1).jpg',
    'assets/descarga (2).jpg',
    'assets/descarga (3).jpg',
    'assets/descarga (4).jpg',
    'assets/descarga (5).jpg',
    'assets/descarga (6).jpg',
    'assets/descarga (7).jpg',
    'assets/descarga (8).jpg',
    'assets/descarga (9).jpg',
  ];

  // 2. COMENTARIOS PERSONALIZADOS: Un comentario único para cada una de tus fotos
  final List<String> comentariosEs = [
    "Los impresionantes Pilares de la Creación.", // Comentario para images.jpg
    "Una nebulosa lejana captada en alta resolución.", // descarga (1)
    "Estrellas naciendo en el corazón del cosmos.", // descarga (2)
    "El mapa térmico de la radiación de fondo.", // descarga (3)
    "Los restos de una supernova expandiéndose.", // descarga (4)
    "Una galaxia espiral similar a la nuestra.", // descarga (5)
    "Nubes de gas y polvo estelar.", // descarga (6)
    "Comparativa de lentes de la NASA.", // descarga (7)
    "Un agujero negro absorbiendo materia.", // descarga (8)
    "El horizonte infinito de nuestro universo." // descarga (9)
  ];

  get Provider => null;

  @override
  Widget build(BuildContext context) {
    // Usamos el Provider solo para leer el idioma y el tema que ya tienes fuera
    final settings = Provider.of<SettingsProvider>(context);
    final String language = settings.currentLocale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(language == 'es' ? "Mi Feed Espacial" : "Space Feed"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: misImagenes.length,
        itemBuilder: (context, index) {
          // Pasamos la imagen y su comentario correspondiente según el orden (index)
          return PostCard(
            imageUrl: misImagenes[index],
            username: "NASA_Explorer",
            description: language == 'es' ? comentariosEs[index] : "Amazing space discovery.",
            initialLikes: 100 + index,
          );
        },
      ),
    );
  }
}

// Widget de la tarjeta que gestiona sus propios "Likes"
class PostCard extends StatefulWidget {
  final String imageUrl;
  final String username;
  final String description;
  final int initialLikes;

  PostCard({required this.imageUrl, required this.username, required this.description, required this.initialLikes});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false; // Estado local: ¿el usuario ha dado like?
  late int likes;       // Contador local de likes

  @override
  void initState() {
    super.initState();
    likes = widget.initialLikes; // Inicializamos con el valor que viene del Feed
  }

  // Función para manejar el clic en el corazón
  void handleLike() {
    setState(() {
      isLiked = !isLiked; // Cambia de verdadero a falso y viceversa
      isLiked ? likes++ : likes--; // Suma si da like, resta si lo quita
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.star)),
            title: Text(widget.username, style: TextStyle(fontWeight: FontWeight.bold)),
          ),

          // CARGA DE IMAGEN: Usamos .asset para tus archivos locales de la NASA
          Image.asset(
            widget.imageUrl,
            fit: BoxFit.cover,
            height: 250,
            width: double.infinity,
            // Si el nombre del archivo no coincide exactamente, verás este error
            errorBuilder: (context, error, stackTrace) => Container(
              height: 250,
              color: Colors.grey[200],
              child: Center(child: Text("Error: Imagen no encontrada")),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // BOTÓN DE LIKE: Cambia de color y forma al pulsar
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : null,
                      ),
                      onPressed: handleLike, // Llama a la lógica de sumar/restar
                    ),
                    Text("$likes likes", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                // Aquí aparece el comentario descriptivo de cada imagen
                Text(widget.description, style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}