import 'package:app_movil/dtos/noticia_model.dart';
import 'package:app_movil/screens/noticia/noticia_details_screen.dart';
import 'package:flutter/material.dart';

class NoticiaListItems extends StatefulWidget {
  final List<Noticia> noticias;
  const NoticiaListItems({super.key, required this.noticias});

  @override
  State<NoticiaListItems> createState() => _NoticiaListItemsState();
}

class _NoticiaListItemsState extends State<NoticiaListItems> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: GestureDetector(
            onTap: () => {
              Navigator.pushNamed(context, NoticiaDetailsScreen.routeName,
                  arguments: widget.noticias[index]
                      .id) //'widget' es para usar atributos de la clase
            },
            child: Card(
              elevation: 10,
              child: ListTile(
                leading: Hero(
                    tag: widget.noticias[index].id,
                    child: Image.network(widget.noticias[index].imageUrl)),
                title: Text(
                  widget.noticias[index].fecha,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: widget.noticias.length,
    );
  }
}
