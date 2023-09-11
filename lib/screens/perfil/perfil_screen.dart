import 'package:app_movil/providers/usuario_provider.dart';
import 'package:app_movil/widgets/add_imagen.dart';
import 'package:app_movil/widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isEditing = false; // Variable controlar si se está editando el perfil
  bool isActualized = false;
  //Variables para almacenar la informacion del usuario
  var nombreController = TextEditingController();
  var correoController = TextEditingController();
  var telefonoController = TextEditingController();
  var imagenUrlController = TextEditingController();

//Trae la informacion del usuario provider y guarda en las variables
  _cargarInformacionControladores() {
    final userProvider = Provider.of<UsuarioProvider>(context);
    nombreController.text = userProvider.getNombreUsuario();
    correoController.text = userProvider.getCorreoUsuario();
    telefonoController.text = userProvider.getTelefonoUsuario();
    imagenUrlController.text = userProvider.getImagenUrlUsuario();
  }

// Cambia el estado de edición
  void _onTap() {
    setState(() {
      isEditing = !isEditing;
    });
  }

// Cambia el estado de edición a false
  void _cancelar() {
    setState(() {
      isEditing = false;
    });
  }

// Actualiza los cambios del perfil del usuario
  void _actualizar() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), //Padin

        //Para primero traer los datos del usuario y luego renderizar los widgets
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: Provider.of<UsuarioProvider>(context, listen: false)
                .checkUsuario(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //Cuando la llamada al metodo async se ejecuta
                _cargarInformacionControladores(); //Carga los datos extraidos
                return Column(
                  //Dibuja los widgets necesarios
                  children: [
                    const SizedBox(height: 16.0),
                    //Widget imagen de usuario
                    AddImagenWidget(
                        imageUrl: imagenUrlController.text,
                        icon: Icons.edit,
                        onImageSelected: (XFile? imageFile) {
                          if (imageFile != null) {
                            // Seleccionó una imagen, puedes hacer algo con la ruta (imageFile)
                            print(imageFile);
                          } else {
                            // No se seleccionó ninguna imagen
                          }
                        }),
                    const SizedBox(height: 16.0),

                    //Widget del nombre del usuario
                    Text(
                      nombreController.text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Negrita
                        fontSize:
                            20, // Tamaño de letra más grande (ajusta según tu preferencia)
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    //Widget boton para editar perfil
                    SizedBox(
                      width: 200,
                      child: noPressedButton(context, 'Editar perfil', _onTap,
                          Icons.edit_note_outlined),
                    ),
                    const SizedBox(height: 20.0),

                    //Widget texto Mi informacion
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

                    //Widgets de campos
                    // Campos de correo (editables o no según el estado de edición)
                    reusableTextFormField(
                      'Correo',
                      Icons.mail_outline,
                      correoController,
                      isEditing,
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa un correo válido.';
                        }
                        return null;
                      },
                      TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),

                    // Campos de teléfono (editables o no según el estado de edición)
                    reusableTextFormField(
                      'Teléfono',
                      Icons.phone_iphone_rounded,
                      telefonoController,
                      isEditing,
                      (value) {
                        // Puedes personalizar la lógica de validación según tus requisitos.
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa un número de teléfono válido.';
                        }
                        return null; // Retorna null si la validación es exitosa
                      },
                      TextInputType
                          .phone, // Especifica el tipo de teclado como TextInputType.phone
                    ),
                    const SizedBox(height: 25.0),

                    //Widgets botones cancelar o actualizar segun estado de edicion
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
                  ],
                );
              } else {
                //cuando la llamada el metodo async se inicia (en proceso)
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
