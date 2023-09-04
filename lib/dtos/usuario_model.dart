class Usuario {
  String? uid;
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

  // Constructor de fábrica utilizado para crear una instancia de Usuario a partir de un mapa JSON proveniente de Firebase
  factory Usuario.fromFirebaseJson(Map<String, dynamic> json) {
    return Usuario(
      uid: json['uid'],
      nombre: json['nombre'],
      telefono: json['telefono'],
      correo: json['correo'],
      imageUrl: json['imageUrl'],
    );
  }

  // Método utilizado para convertir una instancia de Usuario a un mapa JSON
  Map<String, Object?> toJson() => {
        'uid': uid,
        'nombre': nombre,
        'telefono': telefono,
        'correo': correo,
        'imagenUrl': imageUrl,
      };

  void setUidUsuario(String uid) {
    this.uid = uid;
  }

  void setNombreUsuario(String nombre) {
    this.nombre = nombre;
  }

  void setTelefonoUsuario(String telefono) {
    this.telefono = telefono;
  }

  void setCorreoUsuario(String correo) {
    this.correo = correo;
  }

  void setImagenUrlUsuario(String imagenUrl) {
    this.imageUrl = imagenUrl;
  }

  String getNombreUsuario() {
    return this.nombre;
  }

  String getTelefonoUsuario() {
    return this.telefono;
  }

  String getCorreoUsuario() {
    return this.correo;
  }

  String getImagenUrlUsuario() {
    return this.imageUrl;
  }
}
