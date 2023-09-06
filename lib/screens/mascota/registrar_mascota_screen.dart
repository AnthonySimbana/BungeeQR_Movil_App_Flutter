import 'package:app_movil/providers/moscota_provider.dart';
import 'package:app_movil/widgets/add_imagen.dart';
import 'package:app_movil/widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_movil/dtos/mascota_model.dart';
import 'package:provider/provider.dart';

class RegistrarMascotaScreen extends StatefulWidget {
  @override
  _RegistrarMascotaScreenState createState() => _RegistrarMascotaScreenState();
}

class _RegistrarMascotaScreenState extends State<RegistrarMascotaScreen> {
  final _formKey = GlobalKey<FormState>();
  var imagenUrlController = TextEditingController();
  var nombreController = TextEditingController();
  var especieController = TextEditingController();
  var generoController = TextEditingController();
  var edadController = TextEditingController();
  var descripcionController = TextEditingController();

  void crearMascota() async {
    if (_formKey.currentState!.validate()) {
      try {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        final User? user = _auth.currentUser;
        String? uid = user?.uid;
        print('uid del propietario de la mascota: $uid ');

        final MascotaProvider mascotaProvider =
            Provider.of<MascotaProvider>(context, listen: false);
        await mascotaProvider.checkMascotas();
        int id = mascotaProvider.totalMascotas + 1;
        print('id de la nueva mascota es: $id');
        //int id = Provider.of<MascotaProvider>(context);
        final mascota = Mascota(
          id: id,
          idUsuario: uid,
          nombre: nombreController.text,
          especie: especieController.text,
          genero: generoController.text,
          edad: edadController.text,
          descripcion: descripcionController.text,
          imageUrl: 'http://placekitten.com/200/200',
          //imageUrl: imagenUrlController.text,
        );

        Provider.of<MascotaProvider>(context, listen: false)
            .addMascota(mascota);
        // Restablecer los controladores de texto después de guardar
        nombreController.clear();
        especieController.clear();
        generoController.clear();
        edadController.clear();
        descripcionController.clear();
        imagenUrlController.clear();

        print('MASCOTA AGREGADA CON EXITO');

        // Mostrar un mensaje de éxito o navegar a otra pantalla si es necesario
        // Puedes utilizar ScaffoldMessenger para mostrar SnackBars o navegar con Navigator.
      } catch (e) {
        print('Error CREARMASCOTA() al guardar la mascota: $e');
        // Manejar errores, por ejemplo, mostrar un mensaje de error al usuario.
      }
    } else {
      print('No se llenaron todos los campos');
    }
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
                AddImagenWidget(imageUrl: '', icon: Icons.add),
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
                }, TextInputType.number),
                const SizedBox(height: 15),
                reusableTextFormField(
                    'Descripcion', Icons.edit, descripcionController, true,
                    (value) {
                  return null; // Retorna null si la validación es exitosa
                }, TextInputType.name),
                SizedBox(height: 20),
                firebaseUIButton(context, 'Guardar', crearMascota),
                /*
                Expanded(
                    child: FutureBuilder(
                  future: Provider.of<UsuarioProvider>(context, listen: false)
                      .checkUsuario(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var usuarioProvider =
                          Provider.of<UsuarioProvider>(context, listen: false);

                      //String id = (mascotaProvider.totalMascotas + 2) as String;
                      usuarioProvider.checkUsuario();
                      String idUsuario = usuarioProvider.usuario.uid as String;
                      return firebaseUIButton(context, 'Guardar', crearMascota);
                    }
                    ;
                  },
                
                )
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
