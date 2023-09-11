import 'package:app_movil/dtos/noticia_model.dart';
import 'package:app_movil/providers/noticia_provider.dart';
import 'package:app_movil/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoticiaDetailsScreen extends StatelessWidget {
  static const routeName = '/noticia-details';

  const NoticiaDetailsScreen({super.key});

  Widget _getNoticiaNameWidget(Noticia noticia) {
    return Expanded(
      child: Text(
        noticia.descripcion,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 20,
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
        backgroundColor: AppColors.primaryColor,
        title: Text('Noticia'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 10),
                Text(noticiaData.fecha),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time),
                SizedBox(width: 10),
                Text(noticiaData.hora),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Descripción:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(noticiaData.descripcion),
          ],
        ),
      ),
    );
  }
}
