import 'package:app_movil/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isEditing = false; // Variable controlar si se está editando el perfil
  TextEditingController nombreController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController imagenUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Inicializa los controladores de texto con los datos actuales del usuario
    nombreController.text = 'Nombre';
    correoController.text =
        'Correo'; // Reemplaza con el correo real del usuario
    telefonoController.text =
        'Telefono'; // Reemplaza con el teléfono real del usuario
    imagenUrlController.text = 'ImagenUrl';
  }

  _cargarUsuario() {
    Provider.of<UsuarioProvider>(context).checkUsuario();
    //_inicializarControladores();
  }

  _inicializarControladores() {
    final userProvider = Provider.of<UsuarioProvider>(context);
    nombreController.text = userProvider.getNombreUsuario();
    correoController.text = userProvider.getCorreoUsuario();
    telefonoController.text = userProvider.getTelefonoUsuario();
    imagenUrlController.text = userProvider.getImagenUrlUsuario();
  }

  @override
  Widget build(BuildContext context) {
    //Se trae a informacion del usuario
    _cargarUsuario();
    _inicializarControladores();
    //Crear el proveedor del usuario y trae su informacion
    /*
    final userProvider = Provider.of<UsuarioProvider>(context);
    nombreController.text = userProvider.getNombreUsuario() ?? '';
    correoController.text = userProvider.getCorreoUsuario() ?? '';
    telefonoController.text = userProvider.getTelefonoUsuario() ?? '';
    imagenUrlController.text = userProvider.getImagenUrlUsuario() ?? '';
  */
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(imagenUrlController.text),
                    // Reemplaza con la URL real de la imagen
                    radius: 60.0,
                  ),
                  Text(nombreController.text),
                  SizedBox(height: 16.0),

                  // Botón para editar perfil
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        isEditing =
                            !isEditing; // Cambia el estado de edición al presionar el botón
                      });
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Editar perfil'),
                  ),
                  SizedBox(height: 16.0),

                  // Campos de correo y teléfono (editables o no según el estado de edición)
                  TextFormField(
                    controller: correoController,
                    readOnly:
                        !isEditing, // Hace el campo de texto no editable si no se está editando
                    decoration: const InputDecoration(
                      labelText: 'Correo electronico',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: telefonoController,
                    readOnly:
                        !isEditing, // Hace el campo de texto no editable si no se está editando
                    decoration: InputDecoration(
                      labelText: 'Telefono',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),

                  // Botones Cancelar y Actualizar (visibles solo cuando se está editando)
                  if (isEditing)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isEditing =
                                  false; // Cancela la edición y vuelve al modo de visualización
                            });
                          },
                          child: Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Aquí debes implementar la lógica para actualizar los datos del usuario
                            // Puedes utilizar correoController.text y telefonoController.text para obtener los nuevos valores
                            // Después de actualizar, cambia isEditing a false para volver al modo de visualización
                            setState(() {
                              isEditing = false;
                            });
                          },
                          child: Text('Actualizar'),
                        ),
                      ],
                    )
                ])));
  }
}

void main() {
  runApp(MaterialApp(
    home: UserProfileScreen(),
  ));
}
