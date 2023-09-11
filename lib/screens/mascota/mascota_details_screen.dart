import 'package:app_movil/dtos/mascota_model.dart';
import 'package:app_movil/dtos/usuario_model.dart';
import 'package:app_movil/providers/moscota_provider.dart';
import 'package:app_movil/providers/usuario_provider.dart';
import 'package:app_movil/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MascotaDetailsScreen extends StatelessWidget {
  static const routeName = '/mascota-details';
  final double coverHeight = 150;
  final double profileHeight = 170;

  const MascotaDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;

    var mascotaData = Provider.of<MascotaProvider>(
      context,
      listen: false,
    ).getMascota(id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Mascota'),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          builTop(mascotaData.imageUrl),
          buildContentMascota(mascotaData),
          FutureBuilder(
              future: Provider.of<UsuarioProvider>(context, listen: false)
                  .checkUsuario(),
              builder: (context, snapshot) {
                Usuario usuarioData =
                    Provider.of<UsuarioProvider>(context, listen: false)
                        .getUsuarioData();
                return buildContentUser(usuarioData);
              }),
        ],
      ),
    );
  }

  Widget buildContentMascota(Mascota mascota) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const Text(
            'Hola, yo soy',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            mascota.nombre,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          buildContactIcons(),
          //SizedBox(height: 10),
          // const Divider(
          //   color: Colors.grey,
          //   height: 20,
          //   thickness: 1,
          // ),

          const Align(
            alignment: Alignment.centerLeft, // Alineación a la izquierda
            child: Text(
              'Sobre mi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [const Text('Nombre:    '), Text(mascota.nombre)],
          ),
          const SizedBox(height: 5),
          Row(
            children: [const Text('Especie:   '), Text(mascota.especie)],
          ),
          const SizedBox(height: 5),
          Row(
            children: [const Text('Genero:    '), Text(mascota.genero)],
          ),
          const SizedBox(height: 5),
          Row(
            children: [const Text('Edad:    '), Text(mascota.edad)],
          ),
          const SizedBox(height: 5),
          Row(
            children: [const Text('Descripcion:  '), Text(mascota.descripcion)],
          ),
        ],
      ),
    );
  }

  Widget buildContentUser(Usuario usuario) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft, // Alineación a la izquierda
            child: Text(
              'Sobre mi dueño',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [const Text('Nombre:    '), Text(usuario.nombre)],
          ),
          const SizedBox(height: 10),
          Row(
            children: [const Text('Telefono:    '), Text(usuario.telefono)],
          ),
          const SizedBox(height: 10),
          Row(
            children: [const Text('Correo:    '), Text(usuario.correo)],
          ),
        ],
      ),
    );
  }

  Widget buildContactIcons() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {
              // Acción cuando se presiona el icono de teléfono
            },
          ),
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () {
              // Acción cuando se presiona el icono de WhatsApp
            },
          ),
          IconButton(
            icon: const Icon(Icons.email),
            onPressed: () {
              // Acción cuando se presiona el icono de correo
            },
          ),
        ],
      ),
    );
  }

  Widget builTop(String? imageUrl) {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(margin: EdgeInsets.only(bottom: bottom), child: buildCover()),
        Positioned(top: top, child: buildProfileImage(imageUrl)),
      ],
    );
  }

  Widget buildCover() => Container(
        color: AppColors.primaryColor,
        width: double.infinity,
        height: coverHeight,
        //fit: BoxFit.cover,
      );

  Widget buildProfileImage(String? imageUrl) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white, // Color del borde
            width: 6.0, // Ancho del borde
          ),
        ),
        child: CircleAvatar(
          radius: profileHeight / 2,
          backgroundColor: AppColors.primaryColor,
          backgroundImage: NetworkImage(imageUrl!),
        ),
      );
}
