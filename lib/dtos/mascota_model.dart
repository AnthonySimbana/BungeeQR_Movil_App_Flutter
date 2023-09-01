class Mascota {
  int id;
  String nombre;
  String especie;
  String genero;
  int edad;
  String descripcion;
  String imageUrl;

  // Constructor
  Mascota({
    required this.id,
    required this.nombre,
    required this.especie,
    required this.genero,
    required this.edad,
    required this.descripcion,
    required this.imageUrl,
  });

  // Constructor de fábrica utilizado para crear una instancia de Mascota a partir de un mapa JSON
  factory Mascota.fromJson(Map<String, dynamic> json) {
    return Mascota(
      id: json['id'],
      nombre: json['nombre'],
      especie: json['especie'],
      genero: json['genero'],
      edad: json['edad'],
      descripcion: json['descripcion'],
      imageUrl: json['sprites']['front_default'],
    );
  }

  // Constructor de fábrica utilizado para crear una instancia de Mascota a partir de un mapa JSON proveniente de Firebase
  factory Mascota.fromFirebaseJson(Map<String, dynamic> json) {
    return Mascota(
      id: json['id'],
      nombre: json['nombre'],
      especie: json['especie'],
      genero: json['genero'],
      edad: json['edad'],
      descripcion: json['descripcion'],
      imageUrl: json['imageUrl'],
    );
  }

  // Método utilizado para convertir una instancia de Mascota a un mapa JSON
  Map<String, Object?> toJson() => {
        'id': id,
        'nombre': nombre,
        'especie': especie,
        'genero': genero,
        'edad': edad,
        'descripcion': descripcion,
        'imageUrl': imageUrl,
      };
}
