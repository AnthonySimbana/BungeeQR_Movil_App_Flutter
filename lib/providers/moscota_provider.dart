import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_movil/dtos/mascota_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MascotaProvider extends ChangeNotifier {
  final List<Mascota> _originalMascotas = [];
  List<Mascota> _mascota = [];

  int get totalMascotas => _mascota.length;

  UnmodifiableListView<Mascota> get mascotas => UnmodifiableListView(_mascota);

  Mascota getMascota(int id) {
    return _mascota.firstWhere((element) => element.id == id);
  }

  void clearSearch() {
    _mascota = [..._originalMascotas];
    notifyListeners();
  }

  void searchMascotasByName(String name) {
    _mascota = _originalMascotas
        .where((element) => element.nombre.contains(name))
        .toList();
    notifyListeners();
  }

  Future<bool> checkMascotas() async {
    if (_mascota.isEmpty) {
      await _initMascotaList();
      return true;
    }
    return false;
  }

//Metodo que permite agregar comentario a a base de datos en FireStore
  void addCommentToPokemonDoc(int id, String comment) {
    var db = FirebaseFirestore.instance;
    final commentObj = <String, dynamic>{'comment': comment};
    var setOptions = SetOptions(merge: true);
    db.collection('mascotas').doc(id.toString()).set(
          commentObj,
          setOptions,
        );
  }

  //Trae todas las mascotas de la base de datos
  Future<void> _initMascotaList() async {
    try {
      var db = FirebaseFirestore.instance;
      var querySnapshot = await db.collection('mascotas').get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          var mascotaData = doc.data() as Map<String, dynamic>;
          _mascota.add(Mascota.fromFirebaseJson(mascotaData));
          _originalMascotas.add(Mascota.fromFirebaseJson(mascotaData));
        }
        notifyListeners();
      } else {
        print("La colección 'mascotas' está vacía en Firestore.");
      }
    } catch (e) {
      print("Error al obtener datos desde Firestore: $e");
    }
  }

  Future<void> addPokemonList(String url) async {
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    var mascotaData = jsonDecode(response.body);
    print('Procesando: $url');

    _mascota.add(Mascota.fromJson(mascotaData)); //Agrega
    _originalMascotas.add(Mascota.fromJson(mascotaData));

    final pokemonDocument = <String, dynamic>{
      //'id': mascotaData['id'],
      'name': mascotaData['name'],
      'id': mascotaData['id'],
      'imageUrl': mascotaData['sprites']['front_default']
    };

    var db = FirebaseFirestore.instance;

    //Crea la base de datos donde el ID ya no es autogenerado, y si encuentra reemplaza su informacion si no encuentra más,
    //pasa un marge y actualiza/añade info
    var setOptions = SetOptions(merge: true);
    db
        .collection("mascotas")
        .doc(mascotaData['id'].toString())
        .set(pokemonDocument, setOptions) //
        .then((value) => print("Success"));
  }
}
