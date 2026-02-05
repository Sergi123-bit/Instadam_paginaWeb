import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// Asegúrate de que el archivo post.dart existe y el nombre de la clase sea Post
import 'post.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  factory DBHelper() => _instance;

  DBHelper._internal();

  // Abre la base de datos o la devuelve si ya está abierta
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Configuración inicial del archivo de base de datos
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'instadam.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // --- CREACIÓN DE TABLAS ---
  Future<void> _createDB(Database db, int version) async {
    // Tabla de Posts: Guarda la info principal de las fotos
    await db.execute('''
      CREATE TABLE posts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imagePath TEXT,
        username TEXT,
        description TEXT,
        date TEXT,
        likes INTEGER DEFAULT 0,
        commentsCount INTEGER DEFAULT 0
      )
    ''');

    // Tabla de Comentarios: Relacionada con un Post específico
    await db.execute('''
      CREATE TABLE comments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        post_id INTEGER,
        username TEXT,
        text TEXT,
        date TEXT,
        FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE CASCADE
      )
    ''');
  }

  // --- MÉTODOS PARA POSTS ---

  // Guarda un nuevo post usando el método toMap del modelo Post
  Future<int> insertPost(Post post) async {
    final db = await database;
    return await db.insert('posts', post.toMap());
  }

  // Recupera todos los posts y los convierte de Mapa a Objetos Post
  Future<List<Post>> getAllPosts() async {
    final db = await database;
    // 'id DESC' hace que los más nuevos salgan arriba del feed
    final List<Map<String, dynamic>> maps = await db.query('posts', orderBy: "id DESC");

    // Aquí es donde suele fallar si el modelo Post no está bien definido
    return List.generate(maps.length, (i) {
      return Post.fromMap(maps[i]);
    });
  }

  // Cuenta cuántos posts tiene un usuario (para la pantalla de Perfil)
  Future<int> getUserPostCount(String username) async {
    final db = await database;
    final result = await db.rawQuery(
        'SELECT COUNT(*) FROM posts WHERE username = ?', [username]
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // Actualiza solo el número de likes en la base de datos
  Future<void> updateLikes(int postId, int newLikes) async {
    final db = await database;
    await db.update(
      'posts',
      {'likes': newLikes},
      where: 'id = ?',
      whereArgs: [postId],
    );
  }

  // --- MÉTODOS PARA COMENTARIOS ---

  // Inserta un comentario y aumenta automáticamente el contador del post
  Future<void> insertComment(int postId, String user, String text) async {
    final db = await database;

    await db.insert('comments', {
      'post_id': postId,
      'username': user,
      'text': text,
      'date': DateTime.now().toString(),
    });

    // Actualizamos el contador de comentarios para que el Feed se vea al día
    await db.rawUpdate(
        'UPDATE posts SET commentsCount = commentsCount + 1 WHERE id = ?',
        [postId]
    );
  }
}