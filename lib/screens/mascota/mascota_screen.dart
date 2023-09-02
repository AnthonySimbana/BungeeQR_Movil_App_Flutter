import 'package:app_movil/providers/moscota_provider.dart';
import 'package:app_movil/widgets/barra_busqueda.dart';
import 'package:app_movil/widgets/mascotas_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MascotaScreen extends StatefulWidget {
  const MascotaScreen({super.key});

  @override
  State<MascotaScreen> createState() => _MascotaScreenWidgetState();
}

class _MascotaScreenWidgetState extends State<MascotaScreen> {
  bool isSearch = false;
  var textSearchController = TextEditingController();

  @override
  void initState() {
    textSearchController.addListener((_searchMascotas));
    super.initState();
  }

  _clearSearch() {
    Provider.of<MascotaProvider>(context, listen: false)
        .searchMascotasByName(textSearchController.text);
  }

  _searchMascotas() {
    if (textSearchController.text.isNotEmpty) {
      Provider.of<MascotaProvider>(context, listen: false)
          .searchMascotasByName(textSearchController.text);
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
                onSearch: _searchMascotas,
                onClear: _clearSearch,
            )),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<MascotaProvider>(context, listen: false)
                  .checkMascotas(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //Cuando la llamada al metodo async se ejecuta
                  return const MascotaList();
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
