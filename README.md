# proyectos_nuevos_2026

Instadam es una plataforma web integral desarrollada íntegramente con el ecosistema Dart. A diferencia de los desarrollos web tradicionales, este proyecto emplea Dart tanto en el lado del cliente como en el servidor, garantizando una cohesión total en el tipado y la lógica de negocio.

Arquitectura y Stack Tecnológico
El proyecto se despliega bajo un modelo de arquitectura unificada:

Entorno de Ejecución: Dart SDK, utilizado para compilar la lógica de la aplicación en activos web optimizados.

Servidor Backend (Dart Server): Implementación de un servidor HTTP (basado en paquetes como shelf) que gestiona las peticiones API, la autenticación y la lógica de servidor.

Frontend (Dart Web): Interfaz construida con Dart para la manipulación dinámica del DOM, proporcionando una experiencia de usuario reactiva sin depender directamente de frameworks JavaScript externos.

Persistencia: Integración con MySQL para el almacenamiento relacional de datos de usuarios e interacciones.

Funcionalidades del Sistema
La plataforma articula los servicios esenciales de una red social moderna:

Control de Acceso: Gestión de sesiones de usuario, registro y validación de credenciales.

Gestión Multimedia: Módulos para la carga, almacenamiento y visualización de publicaciones fotográficas.

Interacción Social: Sistema de feedback mediante comentarios y gestión de estados de "me gusta" en las publicaciones.

Red de Usuarios: Lógica de seguimiento (following) para la personalización del flujo de contenido.

Organización del Repositorio
La estructura sigue el estándar de paquetes de Dart para aplicaciones cliente-servidor:

bin/: Contiene los puntos de entrada del servidor y la lógica de ejecución del backend.

web/: Aloja el punto de entrada de la aplicación web, incluyendo el HTML principal y el código Dart que se compila a JavaScript.

lib/: Repositorio de código compartido, modelos de datos y servicios de comunicación entre el frontend y el backend.

pubspec.yaml: Gestión centralizada de dependencias y configuración del entorno de desarrollo.
