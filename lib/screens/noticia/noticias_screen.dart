import 'package:app_movil/providers/noticia_provider.dart';
import 'package:app_movil/widgets/barra_busqueda.dart';
import 'package:app_movil/widgets/noticias_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoticiaScreen extends StatefulWidget {
  
  const NoticiaScreen({super.key});

  @override
  State<NoticiaScreen> createState() => _NoticiaScreenState();
}

class _NoticiaScreenState extends State<NoticiaScreen> {
  bool isSearch = false;
  var textSearchController = TextEditingController();

  @override
  void initState() {
    textSearchController.addListener((_searchNoticias));
    super.initState();
  }

  _clearSearch() {
    Provider.of<NoticiaProvider>(context, listen: false)
        .searchNoticasByDescription(textSearchController.text);
  }

  _searchNoticias() {
    if (textSearchController.text.isNotEmpty) {
      Provider.of<NoticiaProvider>(context, listen: false)
          .searchNoticasByDescription(textSearchController.text);
    } else {
      _clearSearch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              height: 80,
              child: BarraBusquedaWidget(
                controller: textSearchController,
                onSearch: _searchNoticias,
                onClear: _clearSearch,
              )),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<NoticiaProvider>(context, listen: false)
                  .checkNoticias(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //Cuando la llamada al metodo async se ejecuta
                  return const NoticiasList();
                } else {
                  //cuando la llamada el metodo async se inicia (en proceso)
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
