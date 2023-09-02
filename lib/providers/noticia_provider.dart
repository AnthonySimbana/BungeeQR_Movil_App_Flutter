import 'dart:collection';
import 'dart:convert';
import 'package:app_movil/dtos/noticia_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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
    _noticia = _originalNoticias
        .where((element) => element.descripcion.contains(name))
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

  Future<void> addNoticiaList(String url) async {
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    var noticiaData = jsonDecode(response.body);
    print('Procesando: $url');

    _noticia.add(Noticia.fromJson(noticiaData)); //Agrega
    _originalNoticias.add(Noticia.fromJson(noticiaData));

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
}