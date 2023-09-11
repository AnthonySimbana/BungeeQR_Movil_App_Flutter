import 'package:app_movil/dtos/noticia_model.dart';
import 'package:app_movil/providers/noticia_provider.dart';
import 'package:app_movil/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoticiaDetailsScreen extends StatelessWidget {
  static const routeName = '/noticia-details';

  const NoticiaDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    var noticiaData = Provider.of<NoticiaProvider>(
      context,
      listen: false,
    ).getNoticia(id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Noticia'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 10),
                Text(noticiaData.fecha),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 10),
                Text(noticiaData.hora),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Descripción:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(noticiaData.descripcion),
          ],
        ),
      ),
    );
  }
}
