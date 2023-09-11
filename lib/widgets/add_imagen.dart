import 'dart:io';
import 'package:app_movil/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImagenWidget extends StatefulWidget {
  String imageUrl;
  final IconData icon; // Agrega este atributo
  final Function(XFile?) onImageSelected; // Agrega este atributo

  AddImagenWidget({
    required this.imageUrl,
    required this.icon,
    required this.onImageSelected,
  });

  @override
  _AddImagenWidget createState() => _AddImagenWidget();
}

class _AddImagenWidget extends State<AddImagenWidget> {
  String?
      _selectedImagePath; // Variable de estado para la ruta de la imagen seleccionada
  File? imagenFile;

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Cámara'),
              onTap: () async {
                //final imagen = await getImage();
                Navigator.of(context)
                    .pop(await picker.pickImage(source: ImageSource.camera));
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Galería'),
              onTap: () async {
                Navigator.of(context)
                    .pop(await picker.pickImage(source: ImageSource.gallery));
              },
            ),
          ],
        );
      },
    );

    if (pickedFile != null) {
      // Llama al callback con la URL de la imagen seleccionada
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
      widget.onImageSelected(pickedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (_selectedImagePath != null) {
      imageProvider = FileImage(File(_selectedImagePath!));
    } else {
      imageProvider = NetworkImage(widget.imageUrl);
    }

    return Stack(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: CircleAvatar(
            backgroundColor:
                Color.fromARGB(0, 156, 152, 152), // Añade esta línea
            backgroundImage: imageProvider,
            radius: 60.0,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              _pickImage(context); // Abre el menú de opciones al tocar el ícono
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.primaryColor,
              ),
              child: Icon(
                widget.icon, // Utiliza el ícono especificado
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
