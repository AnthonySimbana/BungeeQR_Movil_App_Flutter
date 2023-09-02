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
            child: Container(
              height: 115, //altura de cada elemento,
              child: Card(
                elevation: 10,
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  // leading: Container(
                  //   width: 100,
                  //   height: 200,
                  //   child:
                  //     Image.network(
                  //       'http://placekitten.com/200/300',
                  //       fit: BoxFit.cover,
                  //       repeat: ImageRepeat.noRepeat,
                  //     ),
                  //   ),
                  leading: AspectRatio(
                    aspectRatio: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2.0),
                      child: Image.network( widget.noticias[index].imageUrl,
                          fit: BoxFit.cover, repeat: ImageRepeat.noRepeat),
                    ),
                  ),
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.noticias[index].fecha),
                        Text(widget.noticias[index].descripcion),
                         
                      ]),
                  
                  ),
                ),
              ),
            ),
          );
        },

            // child: Card(
            //   elevation: 10,
            //   child: ListTile(
            //     leading: Hero(
            //         tag: widget.noticias[index].id,
            //         child: Image.network(widget.noticias[index].imageUrl)),
            //     title: Text(
            //       widget.noticias[index].fecha,
            //     ),
            //   ),
            // ),
      itemCount: widget.noticias.length,
    );
  }
}
