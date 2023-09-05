class Noticia {
  int id;
  String hora;
  String fecha;
  String ubicacion;
  String descripcion;
  String imageUrl;

  // Constructor
  Noticia({
    required this.id,
    required this.hora,
    required this.fecha,
    required this.ubicacion,
    required this.descripcion,
    required this.imageUrl,
  });

  // Constructor de fábrica utilizado para crear una instancia de Noticia a partir de un mapa JSON proveniente de Firebase
  factory Noticia.fromFirebaseJson(Map<String, dynamic> json) {
    return Noticia(
      id: json['id'],
      hora: json['hora'],
      fecha: json['fecha'],
      ubicacion: json['ubicacion'],
      descripcion: json['descripcion'],
      imageUrl: json['imageUrl'],
    );
  }

  // Método utilizado para convertir una instancia de Noticia a un mapa JSON
  Map<String, Object?> toJson() => {
        'id': id,
        'hora': hora,
        'fecha': fecha,
        'ubicacion': ubicacion,
        'descripcion': descripcion,
        'imageUrl': imageUrl,
      };
}
