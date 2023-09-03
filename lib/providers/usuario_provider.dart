import 'dart:collection';
import 'dart:convert';
import 'package:app_movil/dtos/noticia_model.dart';
import 'package:app_movil/dtos/usuario_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider extends ChangeNotifier {
  Usuario usuario = Usuario(
      uid: '', nombre: 'MARTIN', telefono: '', correo: '', imageUrl: '');

  Future<bool> checkUsuario() async {
    await _initUsuario();
    /*
    if (usuario == null) {
      print('Usuario vacio');

      await _initUsuario();
      return true;
    }
    print('Usuario con datos');

    return false;
    */
    return true;
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

          print(userData['uid']);
          print(userData['nombre']);
          print(userData['telefono']);
          print(userData['correo']);

          usuario.setUidUsuario(userData['uid']);
          usuario.setNombreUsuario(userData['nombre']);
          usuario.setTelefonoUsuario(userData['telefono']);
          usuario.setCorreoUsuario(userData['correo']);
          usuario.setImagenUrlUsuario(userData['imageUrl']);
          print('Aqu se imprime lo restante');

          print(usuario.getCorreoUsuario());
          print(usuario.getImagenUrlUsuario());
          print(usuario.getCorreoUsuario());
          print(usuario.getCorreoUsuario());
          print(usuario.getCorreoUsuario());
          print('Hola hdm');
          // usuario = Usuario.fromFirebaseJson(userData);
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
