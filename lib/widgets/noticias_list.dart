import 'package:app_movil/providers/noticia_provider.dart';
import 'package:app_movil/widgets/noticias_list_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoticiasList extends StatefulWidget {
  const NoticiasList({super.key});

  @override
  State<NoticiasList> createState() => _NoticiasListState();
}

class _NoticiasListState extends State<NoticiasList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoticiaProvider>(builder: (context, provider, child) {
      return NoticiaListItems(
          noticias: provider
              .noticias); //Wiget que va a reenderizar el arreglo de pokemons
    });
  }
}
