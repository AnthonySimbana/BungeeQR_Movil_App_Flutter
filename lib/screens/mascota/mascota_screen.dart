import 'package:app_movil/providers/moscota_provider.dart';
import 'package:app_movil/widgets/barra_busqueda.dart';
import 'package:app_movil/widgets/mascotas_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    FirebaseAuth.instance.authStateChanges().listen(_onUserChange);
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

  void _onUserChange(User? user) {
    if (user != null) {
      // El usuario inició sesión, realiza las acciones necesarias
      // Aquí puedes cargar las mascotas del nuevo usuario si es necesario.
    } else {
      // El usuario cerró la sesión, reinicia los datos de las mascotas.
      Provider.of<MascotaProvider>(context, listen: false).cleanList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
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
                  .checkMascotas(user!.uid.toString()),
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
