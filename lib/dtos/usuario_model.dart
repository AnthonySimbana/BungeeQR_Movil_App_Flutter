class Usuario {
  String uid;
  String nombre;
  String telefono;
  String correo;
  String imageUrl;

  // Constructor
  Usuario({
    required this.uid,
    required this.nombre,
    required this.telefono,
    required this.correo,
    required this.imageUrl,
  });
/*
  Usuario(){
     this.uid = '',
     this.nombre = '',
     this.telefono = '' ,
     this.correo= '',
     this.imageUrl= ''
  }
*/
  // Constructor de fábrica utilizado para crear una instancia de Usuario a partir de un mapa JSON
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      uid: json['uid'],
      nombre: json['nombre'],
      telefono: json['telefono'],
      correo: json['correo'],
      imageUrl: json['sprites']['front_default'],
    );
  }

  // Constructor de fábrica utilizado para crear una instancia de Usuario a partir de un mapa JSON proveniente de Firebase
  factory Usuario.fromFirebaseJson(Map<String, dynamic> json) {
    return Usuario(
      uid: json['uid'] ?? '',
      nombre: json['nombre'] ?? '',
      telefono: json['telefono'] ?? '',
      correo: json['correo'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  // Método utilizado para convertir una instancia de Usuario a un mapa JSON
  Map<String, Object?> toJson() => {
        'uid': uid,
        'nombre': nombre,
        'telefono': telefono,
        'correo': correo,
        'imageUrl': imageUrl,
      };
}
