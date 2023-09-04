import 'package:app_movil/providers/usuario_provider.dart';
import 'package:app_movil/widgets/reusable_widget.dart';
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
  //late final Provider userProvider;

  @override
  void initState() {
    // Inicializa los controladores de texto con los datos actuales del usuario
    nombreController.text = 'Nombre';
    correoController.text =
        'Correo'; // Reemplaza con el correo real del usuario
    telefonoController.text =
        'Telefono'; // Reemplaza con el teléfono real del usuario
    imagenUrlController.text = 'ImagenUrl';
    //_cargarUsuario();
    //_inicializarControladores();
    //_cargarUsuario();
    super.initState();
  }

  Future<void> _cargarUsuario() async {
    await Provider.of<UsuarioProvider>(context).checkUsuario();
    //_inicializarControladores();
  }

  Future<void> _inicializarControladores() async {
    _cargarUsuario();
    final userProvider = Provider.of<UsuarioProvider>(context);
    nombreController.text = userProvider.getNombreUsuario();
    correoController.text = userProvider.getCorreoUsuario();
    telefonoController.text = userProvider.getTelefonoUsuario();
    imagenUrlController.text = userProvider.getImagenUrlUsuario();
  }

  Future<void> reloadData() async {
    await _inicializarControladores();
  }

  void _onTap() {
    setState(() {
      isEditing =
          !isEditing; // Cambia el estado de edición al presionar el botón
    });
  }

  void _cancelar() {
    setState(() {
      isEditing = false;
    });
  }

  void _actualizar() {}

  @override
  Widget build(BuildContext context) {
    //Se trae a informacion del usuario
    //_cargarUsuario();
    _inicializarControladores();
    reloadData();
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
                  const SizedBox(height: 16.0),
                  //Nombre del usuario
                  Text(
                    nombreController.text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, // Negrita
                      fontSize:
                          20, // Tamaño de letra más grande (ajusta según tu preferencia)
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Botón para editar perfil
                  SizedBox(
                    width: 200,
                    child: noPressedButton(context, 'Editar perfil', _onTap,
                        Icons.edit_note_outlined),
                  ),

                  const SizedBox(height: 20.0),

                  const Align(
                    alignment:
                        Alignment.centerLeft, // Alineación a la izquierda
                    child: Text(
                      'Mi información',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Campos de correo (editables o no según el estado de edición)
                  reusableTextFormField('Correo', Icons.mail_outline,
                      correoController, isEditing),
                  const SizedBox(height: 16.0),

                  // Campos de teléfono (editables o no según el estado de edición)
                  reusableTextFormField('Telefono', Icons.phone_iphone_rounded,
                      telefonoController, isEditing),
                  const SizedBox(height: 25.0),

                  // Botones Cancelar y Actualizar (visibles solo cuando se está editando)
                  if (isEditing)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 150,
                          child:
                              noPressedButton(context, 'Cancelar', _cancelar),
                        ),
                        SizedBox(
                          width: 150,
                          child: firebaseUIButton(
                              context, 'Actualizar', _actualizar),
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
