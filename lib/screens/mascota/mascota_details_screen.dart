import 'package:app_movil/dtos/mascota_model.dart';
import 'package:app_movil/providers/moscota_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MascotaDetailsScreen extends StatelessWidget {
  static const routeName = '/mascota-details';
  //final String pokemonId;

  const MascotaDetailsScreen({super.key});

  Widget _getMascotaNameWidget(Mascota mascota) {
    return Expanded(
      child: Text(
        mascota.nombre,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.blue,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    var mascotaData = Provider.of<MascotaProvider>(
      context,
      listen: false,
    ).getMascota(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mascota'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: mascotaData.id,
              child: SizedBox(
                height: 300,
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(mascotaData.imageUrl),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 20,
              ),
              child: Row(
                children: [
                  _getMascotaNameWidget(mascotaData),
                  //PokemonFavorite(id: mascotaData.id)
                ],
              ),
            ),
            //InputComment(id: mascotaData.id),
          ],
        ),
      ),
    );
  }
}
