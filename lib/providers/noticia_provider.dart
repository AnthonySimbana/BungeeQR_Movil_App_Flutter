import 'dart:collection';
import 'package:app_movil/dtos/noticia_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class NoticiaProvider extends ChangeNotifier {
  List<Noticia> _originalNoticias = [];
  List<Noticia> _noticia = [];

  int get totalNoticias => _noticia.length;

  UnmodifiableListView<Noticia> get noticias => UnmodifiableListView(_noticia);

  Noticia getNoticia(int id) {
    return _noticia.firstWhere((element) => element.id == id);
  }

  void cleanList() {
    _originalNoticias = [];
    _noticia = [];
  }

  void clearSearch() {
    _noticia = [..._originalNoticias];
    notifyListeners();
  }

  void searchNoticasByDescription(String name) {
    final normalizedSearch = name.toLowerCase(); //Tranformar a minusculas
    _noticia = _originalNoticias
        .where((element) =>
            element.descripcion.toLowerCase().contains(normalizedSearch))
        .toList();
    notifyListeners();
  }

  Future<bool> checkNoticias() async {
    if (_noticia.isEmpty) {
      await _initNoticiasList();
      return true;
    }
    return false;
  }

  //Trae todas las noticias de la base de datos
  Future<void> _initNoticiasList() async {
    try {
      var db = FirebaseFirestore.instance;
      var querySnapshot = await db.collection('noticias').get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          var noticiaData = doc.data() as Map<String, dynamic>;
          _noticia.add(Noticia.fromFirebaseJson(noticiaData));
          _originalNoticias.add(Noticia.fromFirebaseJson(noticiaData));
        }
        notifyListeners();
      } else {
        print("La colección 'noticias' está vacía en Firestore.");
      }
    } catch (e) {
      print("Error al obtener datos desde Firestore: $e");
    }
  }

  Future<void> addNoticia(Noticia noticia) async {
    final noticiaDocument = noticia.toJson();
    var db = FirebaseFirestore.instance;
    var setOptions = SetOptions(merge: true);
    try {
      await db
          .collection("noticias")
          .doc(noticia.id.toString())
          .set(noticiaDocument, setOptions)
          .then((value) => print("Success"));
      print('Se ingreso con exito la noticia');
      cleanList();
      _initNoticiasList();
    } catch (e) {
      print('Error al guardar en la base de datos: $e');
    }
  }
}
