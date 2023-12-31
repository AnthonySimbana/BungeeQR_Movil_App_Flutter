import 'package:app_movil/providers/moscota_provider.dart';
import 'package:app_movil/widgets/mascotas_list_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MascotaList extends StatefulWidget {
  const MascotaList({super.key});

  @override
  State<MascotaList> createState() => _MascotaListState();
}

class _MascotaListState extends State<MascotaList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MascotaProvider>(builder: (context, provider, child) {
      return MascotaListItems(
          mascotas: provider
              .mascotas); //Wiget que va a reenderizar el arreglo de Mascotas
    });
  }
}
