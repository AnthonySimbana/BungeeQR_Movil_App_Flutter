import 'dart:io';

import 'package:app_movil/dtos/noticia_model.dart';
import 'package:app_movil/providers/noticia_provider.dart';
import 'package:app_movil/service/upload_image.dart';
import 'package:app_movil/utils/color_utils.dart';
import 'package:app_movil/widgets/add_imagen.dart';
import 'package:app_movil/widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegistrarNoticiaScreen extends StatefulWidget {
  const RegistrarNoticiaScreen({super.key});

  @override
  _RegistrarNoticiacreenState createState() => _RegistrarNoticiacreenState();
}

class _RegistrarNoticiacreenState extends State<RegistrarNoticiaScreen> {
  File? imageDataUpload; //File de la foto o imagen
  final _formKey = GlobalKey<FormState>(); //Key del formulario
  //Variables para registrar una noticia
  var horaController = TextEditingController();
  var fechaController = TextEditingController();
  var ubicacionController = TextEditingController();
  var descripcionController = TextEditingController();
  String? imagenUrl =
      'https://firebasestorage.googleapis.com/v0/b/bungeeqr.appspot.com/o/Iconos%2FaddMascota.jpg?alt=media&token=901cd5a4-fff6-4767-b67e-8b112961ef23';
  //Agregar imagen de noticia y actualizar su url
  Future<void> _registrarNoticia() async {
    String? imagenUrlAux = await uploadImageNoticia(imageDataUpload!);
    setState(() {
      imagenUrl = imagenUrlAux;
    });
  }

  //Valida el formulario lleno e imagen existentes
  _validateData() {
    return _formKey.currentState!.validate() && imageDataUpload != null;
  }

  _validateCrearNoticia() async {
    final uploaded = await crearNoticia();
    if (uploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Noticia agregada correctamente")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al agregar la noticia")));
    }
  }

  //Agrega la noticia en firebase
  Future<bool> crearNoticia() async {
    if (_validateData()) {
      //De ser los campos validos, entonces:
      try {
        await _registrarNoticia(); //Primero la carga al Storage Fireba
        //Obtiene el id de la nueva noticia
        final NoticiaProvider noticiaProvider =
            Provider.of<NoticiaProvider>(context, listen: false);
        await noticiaProvider.checkNoticias();
        int id = noticiaProvider.totalNoticias + 1;
        //Crear objeto noticia
        final noticia = Noticia(
          id: id,
          hora: horaController.text,
          fecha: fechaController.text,
          ubicacion: ubicacionController.text,
          descripcion: descripcionController.text,
          imageUrl: imagenUrl!,
        );

        //Agrega la noticia en firebase
        Provider.of<NoticiaProvider>(context, listen: false)
            .addNoticia(noticia);

        // Restablecer los controladores de texto después de guardar
        _reiniciarControladores();

        return true;
      } catch (e) {
        print('Error al crear registrar formulario de noticia: $e');
        return false;
      }
    }
    return false;
  }

  _reiniciarControladores() {
    horaController.clear();
    fechaController.clear();
    ubicacionController.clear();
    descripcionController.clear();
    setState(() {
      imagenUrl =
          'https://firebasestorage.googleapis.com/v0/b/bungeeqr.appspot.com/o/Iconos%2FaddMascota.jpg?alt=media&token=901cd5a4-fff6-4767-b67e-8b112961ef23';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Usa extendBody en lugar de extendBodyBehindAppBar
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Agregar noticia'),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft:
                Radius.circular(50.0), // Ajusta el radio según tus necesidades
            bottomRight:
                Radius.circular(50.0), // Ajusta el radio según tus necesidades
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
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
                  reusableTextFormFieldTime(
                      'Hora *', Icons.edit, horaController, true, (value) {
                    // Puedes personalizar la lógica de validación según tus requisitos.
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecciona una hora';
                    }
                    return null; // Retorna null si la validación es exitosa
                  }, context),
                  const SizedBox(height: 15),
                  reusableTextFormFieldDate(
                      'Fecha *', Icons.edit, fechaController, true, (value) {
                    // Puedes personalizar la lógica de validación según tus requisitos.
                    if (value == null || value.isEmpty) {
                      return 'Por favor, seleccione una fecha';
                    }
                    return null; // Retorna null si la validación es exitosa
                  }, context),
                  const SizedBox(height: 15),
                  reusableTextFormField(
                      'Ubicacion *', Icons.edit, ubicacionController, true,
                      (value) {
                    // Puedes personalizar la lógica de validación según tus requisitos.
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa la ubicacion';
                    }
                    return null; // Retorna null si la validación es exitosa
                  }, TextInputType.name),
                  const SizedBox(height: 15),
                  reusableTextFormField(
                      'Descripcion', Icons.edit, descripcionController, true,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa una descripcion';
                    }
                    return null; // Retorna null si la validación es exitosa
                  }, TextInputType.name),
                  const SizedBox(height: 20),
                  firebaseUIButton(context, 'Guardar', _validateCrearNoticia),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
