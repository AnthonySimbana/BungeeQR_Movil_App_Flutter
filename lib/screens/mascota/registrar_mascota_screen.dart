import 'package:app_movil/widgets/add_imagen.dart';
import 'package:app_movil/widgets/reusable_widget.dart';
import 'package:flutter/material.dart';

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

  onTap() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Aquí puedes hacer algo con los datos ingresados,
      // como guardarlos en una base de datos.
      // Luego, puedes navegar a otra pantalla o realizar
      // la acción que desees.
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
                firebaseUIButton(context, 'Guardar', onTap),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
