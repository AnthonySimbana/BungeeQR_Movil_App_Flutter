import 'dart:collection';
import 'dart:convert';

import 'package:app_movil/dtos/mascota_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> _initMascotaList() async {
    var client = http.Client();
    var response = await client.get(Uri.http('pokeapi.co', '/api/v2/pokemon'));
    print('statusPokemon: ${response.statusCode}'); //codigo de retorno HTTP
    //20X -> OK
    //40X -> Errores de lado del cliente (404, 403)
    //50X -> Errores de lado del servidor (500)
    //print('pokemon List: ${response.body}');
    //DART - JSON -> Map<String, Object> -> Object -> List
    var decodedResponse = jsonDecode(response.body);
    var results = decodedResponse['results'] as List;
    for (var ri in results) {
      //ri -Map<String, Object>
      var url = ri['url'] as String;
      await addPokemonList(url);
    }
    notifyListeners();
  }

  Future<void> addPokemonList(String url) async {
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    var pokemonData = jsonDecode(response.body);
    print('Procesando: $url');

    _mascota.add(Mascota.fromJson(pokemonData)); //Agrega
    _originalMascotas.add(Mascota.fromJson(pokemonData));

    final pokemonDocument = <String, dynamic>{
      //'id': pokemonData['id'],
      'name': pokemonData['name'],
      'id': pokemonData['id'],
      'imageUrl': pokemonData['sprites']['front_default']
    };

    var db = FirebaseFirestore.instance;

    //Crea la base de datos donde el ID ya no es autogenerado, y si encuentra reemplaza su informacion si no encuentra más,
    //pasa un marge y actualiza/añade info
    var setOptions = SetOptions(merge: true);
    db
        .collection("mascotas")
        .doc(pokemonData['id'].toString())
        .set(pokemonDocument, setOptions) //
        .then((value) => print("Success"));
  }
}
