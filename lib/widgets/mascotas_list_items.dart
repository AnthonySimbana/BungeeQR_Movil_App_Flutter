import 'package:flutter/material.dart';
import '../dtos/mascota_model.dart';
import '../screens/mascota/mascota_details_screen.dart';

class MascotaListItems extends StatefulWidget {
  final List<Mascota> mascotas;
  const MascotaListItems({super.key, required this.mascotas});

  @override
  State<MascotaListItems> createState() => _MascotaListItemsState();
}

class _MascotaListItemsState extends State<MascotaListItems> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: GestureDetector(
            onTap: () => {
              Navigator.pushNamed(context, MascotaDetailsScreen.routeName,
                  arguments: widget.mascotas[index]
                      .id) //'widget' es para usar atributos de la clase
            },
            child: Card(
              elevation: 10,
              child: ListTile(
                leading: Hero(
                    tag: widget.mascotas[index].id,
                    child: Image.network(widget.mascotas[index].imageUrl)),
                title: Text(
                  widget.mascotas[index].nombre,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: widget.mascotas.length,
    );
  }
}
