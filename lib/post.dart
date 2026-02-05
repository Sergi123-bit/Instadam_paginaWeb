// Archivo: post.dart

class Post {
  final int? id;
  final String imagePath;
  final String username;
  final String description;
  final String date;
  int likes;
  int commentsCount;

  // Constructor de la clase
  Post({
    this.id,
    required this.imagePath,
    required this.username,
    required this.description,
    required this.date,
    this.likes = 0,
    this.commentsCount = 0,
  });

  // Convierte un objeto Post a un Mapa para SQFlite
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'imagePath': imagePath,
      'username': username,
      'description': description,
      'date': date,
      'likes': likes,
      'commentsCount': commentsCount,
    };
  }

  // Crea un objeto Post desde un Mapa (el que viene de la base de datos)
  // Este es el método que invoca el DBHelper en List.generate
  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      imagePath: map['imagePath'] ?? '',
      username: map['username'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      likes: map['likes'] ?? 0,
      commentsCount: map['commentsCount'] ?? 0,
    );
  }
}