import 'dart:collection';
import 'dart:convert';
import 'package:app_movil/dtos/noticia_model.dart';
import 'package:app_movil/dtos/usuario_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider extends ChangeNotifier {
  Usuario? _usuario;

  Future<bool> checkUsuario() async {
    if (_usuario == null) {
      print('Usuario vacio');

      await _initUsuario();
      return true;
    }
    print('Usuario con datos');

    return false;
  }

  Future<void> _initUsuario() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User? user = _auth.currentUser;
      if (user != null) {
        print('Usuario no null');
        String? uid = _auth.currentUser?.uid; //uid del usuario actual
        print(uid);

        final userDoc = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(uid)
            .get(); //Dato del usuario de firebase

        if (userDoc.exists) {
          // El documento existe, obtén los datos del usuario
          print('EL documento existe');
          var userData = userDoc.data() as Map<String, dynamic>;
          userData.forEach((key, value) {
            print('$key: $value');
          });
          _usuario = Usuario.fromFirebaseJson(userData);
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

  String? getNombreUsuario() {
    return _usuario?.nombre;
  }

  String? getTelefonoUsuario() {
    return _usuario?.telefono;
  }

  String? getCorreoUsuario() {
    return _usuario?.correo;
  }

  String? getImagenUrlUsuario() {
    return _usuario?.imageUrl;
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
