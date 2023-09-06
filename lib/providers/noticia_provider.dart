import 'dart:collection';
import 'package:app_movil/dtos/noticia_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class NoticiaProvider extends ChangeNotifier {
  final List<Noticia> _originalNoticias = [];
  List<Noticia> _noticia = [];

  int get totalNoticias => _noticia.length;

  UnmodifiableListView<Noticia> get noticias => UnmodifiableListView(_noticia);

  Noticia getNoticia(int id) {
    return _noticia.firstWhere((element) => element.id == id);
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

  Future<void> addNoticiaList(String url) async {}
}
