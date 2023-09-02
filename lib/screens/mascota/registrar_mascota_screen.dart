import 'package:flutter/material.dart';

class RegistrarMascotaScreen extends StatefulWidget {
  @override
  _RegistrarMascotaScreenState createState() => _RegistrarMascotaScreenState();
}

class _RegistrarMascotaScreenState extends State<RegistrarMascotaScreen> {
  final _formKey = GlobalKey<FormState>();
  String nombre = '';
  String especie = '';
  String genero = '';
  int edad = 0;
  String descripcion = '';
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre de la mascota.';
                  }
                  return null;
                },
                onSaved: (value) {
                  nombre = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Especie'),
                onSaved: (value) {
                  especie = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Género'),
                onSaved: (value) {
                  genero = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  edad = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
                onSaved: (value) {
                  descripcion = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'URL de la Imagen'),
                onSaved: (value) {
                  imageUrl = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Aquí puedes hacer algo con los datos ingresados,
                    // como guardarlos en una base de datos.
                    // Luego, puedes navegar a otra pantalla o realizar
                    // la acción que desees.
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
