import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_movil/dtos/mascota_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class MascotaProvider extends ChangeNotifier {
  List<Mascota> _originalMascotasUser = [];
  List<Mascota> _mascotaUser = [];
  int _totalMascotas = 0;

  int get totalMascotas => _totalMascotas;

  UnmodifiableListView<Mascota> get mascotas =>
      UnmodifiableListView(_mascotaUser);

  Mascota getMascota(int id) {
    return _mascotaUser.firstWhere((element) => element.id == id);
  }

  void cleanList() {
    _originalMascotasUser.clear();
    _mascotaUser.clear();
  }

  void clearSearch() {
    _mascotaUser = [..._originalMascotasUser];
    notifyListeners();
  }

  void searchMascotasByName(String name) {
    final normalizedSearch = name.toLowerCase(); //Tranformar a minusculas

    _mascotaUser = _originalMascotasUser
        .where((element) =>
            element.nombre.toLowerCase().contains(normalizedSearch))
        .toList();
    notifyListeners();
  }

  Future<bool> checkMascotas(String idUsuario) async {
    if (_mascotaUser.isEmpty) {
      await _initMascotaList(idUsuario);
      return true;
    }
    return false;
  }

  //Trae todas las mascotas de la base de datos
  Future<void> _initMascotaList(String idUsuario) async {
    cleanList();
    try {
      var db = FirebaseFirestore.instance;
      var querySnapshotUser = await db
          .collection('mascotas')
          .where('idUsuario', isEqualTo: idUsuario)
          .get();

      if (querySnapshotUser.docs.isNotEmpty) {
        for (var doc in querySnapshotUser.docs) {
          var mascotaData = doc.data() as Map<String, dynamic>;
          _mascotaUser.add(Mascota.fromFirebaseJson(mascotaData));
          _originalMascotasUser.add(Mascota.fromFirebaseJson(mascotaData));
        }
        notifyListeners();
        print('Se agregaron los datos de las mascotas');
      } else {
        print("La colección 'mascotas' está vacía en Firestore.");
      }

      var querySnapshotTotal = await db.collection('mascotas').get();

      if (querySnapshotTotal.docs.isNotEmpty) {
        _totalMascotas = 0;
        print(_totalMascotas);
        for (var doc in querySnapshotTotal.docs) {
          _totalMascotas++;
          print(_totalMascotas);
          //var mascotaData = doc.data() as Map<String, dynamic>;
          //_mascotas.add(Mascota.fromFirebaseJson(mascotaData));
        }
        print('Se agregaron los datos de las mascotas');
      } else {
        print("La colección 'mascotas' está vacía en Firestore.");
      }
      notifyListeners();
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
      //print('Se ingreso con exito la mascota');
      cleanList();
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User? user = _auth.currentUser;
      _initMascotaList(user!.uid.toString());
    } catch (e) {
      print('Error al guardar en la base de datos: $e');
    }
  }
}
