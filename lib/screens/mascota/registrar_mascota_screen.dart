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
  
  List<String> especieOptions = ['Perro', 'Gato'];
  String selectedEspecie = 'Perro'; // Valor inicial seleccionado
  List<String> generoOptions = ['Macho', 'Hembra'];
  String selectedGenero = 'Macho'; // Valor inicial seleccionado
  var edadController = TextEditingController();
  var descripcionController = TextEditingController();
  String? imagenUrl =
      'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.culturarecreacionydeporte.gov.co%2Fes%2Fbogotanitos%2Fbiodiverciudad%2Flas-mascotas&psig=AOvVaw0eBgKoy1-1bAn0OQLst4l9&ust=1694559119555000&source=images&cd=vfe&opi=89978449&ved=0CA4QjRxqFwoTCPDGgvzSo4EDFQAAAAAdAAAAABAJ';
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
          especie: selectedEspecie,
          genero: selectedGenero,
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
    selectedEspecie = 'Perro';
    selectedGenero =  'Macho';
    edadController.clear();
    descripcionController.clear();
    setState(() {
      imagenUrl =
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.culturarecreacionydeporte.gov.co%2Fes%2Fbogotanitos%2Fbiodiverciudad%2Flas-mascotas&psig=AOvVaw0eBgKoy1-1bAn0OQLst4l9&ust=1694559119555000&source=images&cd=vfe&opi=89978449&ved=0CA4QjRxqFwoTCPDGgvzSo4EDFQAAAAAdAAAAABAJ';
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
                
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Especie *',
                    prefixIcon: Icon(Icons.edit),
                  ),
                  value: selectedEspecie,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedEspecie = newValue!;
                    });
                  },
                  items: especieOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecciona la especie';
                    }
                    return null; // Retorna null si la validación es exitosa
                  },
                ),

                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Género *',
                    prefixIcon: Icon(Icons.edit),
                  ),
                  value: selectedGenero,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGenero = newValue!;
                    });
                  },
                  items: generoOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecciona el género';
                    }
                    return null; // Retorna null si la validación es exitosa
                  },
                ),
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
