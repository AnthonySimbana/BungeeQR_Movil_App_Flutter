import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

//Agregar la imagen de la mascota al Storage de Firebase
final FirebaseStorage storage = FirebaseStorage.instance;
Future<String?> uploadImageMascota(File image) async {
  try {
    final String nameFile = image.path.split("/").last;
    final Reference ref = storage.ref().child("imagesMascotas").child(nameFile);
    final UploadTask uploadTask = ref.putFile(image);
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
    final String url = await snapshot.ref.getDownloadURL();
    if (snapshot.state == TaskState.success) {
      return url;
    } else {
      return null;
    }
  } catch (e) {
    print('Erro en uploadImage $e');
  }

  return null;
}

//Agregar la imagen de la noticia al Storage de Firebase
Future<String?> uploadImageNoticia(File image) async {
  try {
    final String nameFile = image.path.split("/").last;
    final Reference ref = storage.ref().child("imagesNoticias").child(nameFile);
    final UploadTask uploadTask = ref.putFile(image);
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
    final String url = await snapshot.ref.getDownloadURL();
    if (snapshot.state == TaskState.success) {
      return url;
    } else {
      return null;
    }
  } catch (e) {
    print('Erro en uploadImage $e');
  }

  return null;
}
