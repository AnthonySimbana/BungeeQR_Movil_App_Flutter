import 'package:app_movil/dtos/noticia_model.dart';
import 'package:app_movil/providers/moscota_provider.dart';
import 'package:app_movil/providers/noticia_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoticiaDetailsScreen extends StatelessWidget {
  static const routeName = '/noticia-details';
  //final String pokemonId;

  const NoticiaDetailsScreen({super.key});

  Widget _getNoticiaNameWidget(Noticia noticia) {
    return Expanded(
      child: Text(
        noticia.descripcion,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.blue,
          fontSize: 21,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    var noticiaData = Provider.of<NoticiaProvider>(
      context,
      listen: false,
    ).getNoticia(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticia'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: noticiaData.id,
              child: SizedBox(
                height: 300,
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(noticiaData.imageUrl),
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
                  _getNoticiaNameWidget(noticiaData),
                  //PokemonFavorite(id: noticiaData.id)
                ],
              ),
            ),
            //InputComment(id: noticiaData.id),
          ],
        ),
      ),
    );
  }
}
