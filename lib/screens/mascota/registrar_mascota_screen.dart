import 'dart:io';

import 'package:app_movil/providers/moscota_provider.dart';
import 'package:app_movil/service/upload_image.dart';
import 'package:app_movil/widgets/add_imagen.dart';
import 'package:app_movil/widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/dtos/mascota_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegistrarMascotaScreen extends StatefulWidget {
  const RegistrarMascotaScreen({super.key});

  @override
  _RegistrarMascotaScreenState createState() => _RegistrarMascotaScreenState();
}

class _RegistrarMascotaScreenState extends State<RegistrarMascotaScreen> {
  File? imageDataUpload; //File de la foto o imagen
  final _formKey = GlobalKey<FormState>(); //Key del formulario
  //Variables para registrar una mascota
  var nombreController = TextEditingController();
  var especieController = TextEditingController();
  var generoController = TextEditingController();
  var edadController = TextEditingController();
  var descripcionController = TextEditingController();
  String? imagenUrl =
      'https://firebasestorage.googleapis.com/v0/b/bungeeqr.appspot.com/o/Iconos%2FaddMascota.jpg?alt=media&token=901cd5a4-fff6-4767-b67e-8b112961ef23';
  //Agregar imagen mascota la mascota y actualizar su url
  Future<void> _registrarMascota() async {
    String? imagenUrlAux = await uploadImageMascota(imageDataUpload!);
    setState(() {
      imagenUrl = imagenUrlAux;
    });
  }

  //Valida el formulario lleno e imagen existentes
  _validateData() {
    return _formKey.currentState!.validate() && imageDataUpload != null;
  }

  _validateCrearMascota() async {
    final uploaded = await crearMascota();
    if (uploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Mascota agregada correctamente")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al agregar la mascota")));
    }
  }

  //Agrega la mascota en firebase
  Future<bool> crearMascota() async {
    if (_validateData()) {
      //De ser los campos validos, entonces:
      try {
        await _registrarMascota(); //Primero la carga al Storage Fireba
        final FirebaseAuth _auth = FirebaseAuth.instance;
        final User? user = _auth.currentUser;
        String? uid = user?.uid; //Obtiene uid del duenio de la mascota

        //Obtiene el id de la nueva mascota
        final MascotaProvider mascotaProvider =
            Provider.of<MascotaProvider>(context, listen: false);

        await mascotaProvider.checkMascotas(uid!);
        int id = mascotaProvider.totalMascotas + 1;
        //Crear objeto mascota
        final mascota = Mascota(
          id: id,
          idUsuario: uid,
          nombre: nombreController.text,
          especie: especieController.text,
          genero: generoController.text,
          edad: edadController.text,
          descripcion: descripcionController.text,
          imageUrl: imagenUrl,
        );

        //Agrega la mascota en firebase
        Provider.of<MascotaProvider>(context, listen: false)
            .addMascota(mascota);

        // Restablecer los controladores de texto después de guardar
        _reiniciarControladores();

        return true;
      } catch (e) {
        print('Error al crear registrar formulario de mascota: $e');
        return false;
      }
    }
    return false;
  }

  _reiniciarControladores() {
    nombreController.clear();
    especieController.clear();
    generoController.clear();
    edadController.clear();
    descripcionController.clear();
    setState(() {
      imagenUrl =
          'https://firebasestorage.googleapis.com/v0/b/bungeeqr.appspot.com/o/Iconos%2FaddMascota.jpg?alt=media&token=901cd5a4-fff6-4767-b67e-8b112961ef23';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                AddImagenWidget(
                    imageUrl: imagenUrl!,
                    icon: Icons.add,
                    onImageSelected: (XFile? imagePath) {
                      if (imagePath!.path != null) {
                        setState(() {
                          imageDataUpload = File(imagePath.path);
                        });
                      }
                    }),
                const SizedBox(height: 15),
                reusableTextFormField('Nombre de la mascota *', Icons.edit,
                    nombreController, true, (value) {
                  // Puedes personalizar la lógica de validación según tus requisitos.
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un nombre';
                  }
                  return null; // Retorna null si la validación es exitosa
                }, TextInputType.name),
                const SizedBox(height: 15),
                reusableTextFormField(
                    'Especie *', Icons.edit, especieController, true, (value) {
                  // Puedes personalizar la lógica de validación según tus requisitos.
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una especie';
                  }
                  return null; // Retorna null si la validación es exitosa
                }, TextInputType.name),
                const SizedBox(height: 15),
                reusableTextFormField(
                    'Genero *', Icons.edit, generoController, true, (value) {
                  // Puedes personalizar la lógica de validación según tus requisitos.
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el género';
                  }
                  return null; // Retorna null si la validación es exitosa
                }, TextInputType.name),
                const SizedBox(height: 15),
                reusableTextFormField(
                    'Edad *', Icons.edit, edadController, true, (value) {
                  // Puedes personalizar la lógica de validación según tus requisitos.
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la edad';
                  }
                  return null; // Retorna null si la validación es exitosa
                }, TextInputType.name),
                const SizedBox(height: 15),
                reusableTextFormField(
                    'Descripcion', Icons.edit, descripcionController, true,
                    (value) {
                  return null; // Retorna null si la validación es exitosa
                }, TextInputType.name),
                const SizedBox(height: 20),
                firebaseUIButton(context, 'Guardar', _validateCrearMascota),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
