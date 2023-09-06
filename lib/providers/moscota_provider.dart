import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_movil/dtos/mascota_model.dart';
import 'package:flutter/foundation.dart';

class MascotaProvider extends ChangeNotifier {
  List<Mascota> _originalMascotas = [];
  List<Mascota> _mascota = [];

  int get totalMascotas => _mascota.length;

  UnmodifiableListView<Mascota> get mascotas => UnmodifiableListView(_mascota);

  Mascota getMascota(int id) {
    return _mascota.firstWhere((element) => element.id == id);
  }

  void cleanList() {
    _originalMascotas = [];
    _mascota = [];
  }

  void clearSearch() {
    _mascota = [..._originalMascotas];
    notifyListeners();
  }

  void searchMascotasByName(String name) {
    final normalizedSearch = name.toLowerCase(); //Tranformar a minusculas

    _mascota = _originalMascotas
        .where((element) =>
            element.nombre.toLowerCase().contains(normalizedSearch))
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

  /*
  Future<int?> getLastOneMascota() async {
    var db = FirebaseFirestore.instance;
    var mascotasCollection = db.collection('mascotas');
    var mascotasSnapshot =
        await mascotasCollection.orderBy('id', descending: true).limit(1).get();
    if (mascotasSnapshot.docs.isNotEmpty) {
      var ultimoDocumento = mascotasSnapshot.docs.first;
      int? ultimoId = ultimoDocumento['id'];
      // Incrementa el último ID para obtener el nuevo ID
      return ultimoId! + 1;
      // Utiliza nuevoId como el ID para el nuevo documento
    }
    return 0;
  }
  */

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
        print('Se obtuvieron datos de mascotas QUERYSnapshot');
        for (var doc in querySnapshot.docs) {
          var mascotaData = doc.data() as Map<String, dynamic>;
          _mascota.add(Mascota.fromFirebaseJson(mascotaData));
          _originalMascotas.add(Mascota.fromFirebaseJson(mascotaData));
        }
        notifyListeners();
        print('Se agregaron los datos de las mascotas');
      } else {
        print("La colección 'mascotas' está vacía en Firestore.");
      }
    } catch (e) {
      print("Error al obtener datos desde Firestore: $e");
    }
  }

  Future<void> addMascota(Mascota mascota) async {
    final mascotaDocument = mascota.toJson();
    var db = FirebaseFirestore.instance;
    var setOptions = SetOptions(merge: true);
    try {
      await db
          .collection("mascotas")
          .doc(mascota.id.toString())
          .set(mascotaDocument, setOptions)
          .then((value) => print("Success"));
      print('Se ingreso con exito la mascota');
      cleanList();
      _initMascotaList();
    } catch (e) {
      print('Error al guardar en la base de datos: $e');
    }
  }
}
