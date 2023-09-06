import 'package:app_movil/dtos/usuario_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UsuarioProvider extends ChangeNotifier {
  Usuario usuario = Usuario(
      uid: '', nombre: 'MARTIN', telefono: '', correo: '', imageUrl: '');

  Future<bool> checkUsuario() async {
    await _initUsuario();
    return true;
  }

  User? getUser() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    return user;
  }

  Future<void> _initUsuario() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User? user = _auth.currentUser;
      if (user != null) {
        //print('Usuario no null');
        String? uid = _auth.currentUser?.uid; //uid del usuario actual
        //print(uid);

        final userDoc = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(uid)
            .get(); //Dato del usuario de firebase

        if (userDoc.exists) {
          var userData = userDoc.data() as Map<String, dynamic>;
          usuario = Usuario.fromFirebaseJson(userData);
        } else {
          // El documento no existe
          print('Error, el usuario no existe');
        }
      }
    } catch (error) {
      print('Error al obtener el usuario desde Firebase Firestore: $error');
      // Maneja el error de conexión o cualquier otro error que puedas enfrentar
    }
  }

  String getNombreUsuario() {
    return usuario.nombre;
  }

  String getTelefonoUsuario() {
    return usuario.telefono;
  }

  String getCorreoUsuario() {
    return usuario.correo;
  }

  String getImagenUrlUsuario() {
    return usuario.imageUrl;
  }

//Metodo que permite agregar comentario a a base de datos en FireStore
  void addCommentToPokemonDoc(int id, String comment) {
    var db = FirebaseFirestore.instance;
    final commentObj = <String, dynamic>{'comment': comment};
    var setOptions = SetOptions(merge: true);
    db.collection('noticias').doc(id.toString()).set(
          commentObj,
          setOptions,
        );
  }

  void crearPerfilUsuario(
      String? uid, String nombre, String mail, String phone, String imageUrl) {
    var db = FirebaseFirestore.instance;

    Usuario usuario = Usuario(
      uid: uid,
      nombre: nombre,
      correo: mail,
      telefono: phone,
      imageUrl: imageUrl,
    );
// Convertir el objeto Usuario a un mapa
    Map<String, Object?> userData = usuario.toJson();

    // Utilizar el ID de usuario como identificador del documento
    db.collection('usuarios').doc(uid).set(userData).then((_) {
      print('Documento de usuario creado con éxito');
    }).catchError((error) {
      print('Error al crear el documento de usuario: $error');
    });
  }
/*
  Future<void> addNoticiaList(String url) async {

    final pokemonDocument = <String, dynamic>{
      //'id': noticiaData['id'],
      'name': noticiaData['name'],
      'id': noticiaData['id'],
      'imageUrl': noticiaData['sprites']['front_default']
    };

    var db = FirebaseFirestore.instance;

    //Crea la base de datos donde el ID ya no es autogenerado, y si encuentra reemplaza su informacion si no encuentra más,
    //pasa un marge y actualiza/añade info
    var setOptions = SetOptions(merge: true);
    db
        .collection("noticias")
        .doc(noticiaData['id'].toString())
        .set(pokemonDocument, setOptions) //
        .then((value) => print("Success"));
  }
  */
}
