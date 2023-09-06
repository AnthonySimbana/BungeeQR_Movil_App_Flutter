import 'package:app_movil/widgets/qr_widget.dart';
import 'package:flutter/material.dart';
import '../dtos/mascota_model.dart';
import '../screens/mascota/mascota_details_screen.dart';

class MascotaListItems extends StatefulWidget {
  final List<Mascota> mascotas;
  const MascotaListItems({super.key, required this.mascotas});

  @override
  State<MascotaListItems> createState() => _MascotaListItemsState();
}

final String data = "http://placekitten.com/200/300";

class _MascotaListItemsState extends State<MascotaListItems> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(3.0), //espacio entre cada elementos
          child: GestureDetector(
            onTap: () => {
              Navigator.pushNamed(context, MascotaDetailsScreen.routeName,
                  arguments: widget.mascotas[index]
                      .id) //'widget' es para usar atributos de la clase
            },
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
                  aspectRatio: 1.75,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2.0),
                    child: Image.network('http://placekitten.com/200/300',
                        fit: BoxFit.cover, repeat: ImageRepeat.noRepeat),
                  ),
                ),

                title: Text(widget.mascotas[index].nombre,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),

                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.mascotas[index].especie,
                        ),
                        const SizedBox(height: 6.0),
                        Text(widget.mascotas[index].genero),
                        const SizedBox(height: 6.0),
                        Text(widget.mascotas[index].edad),
                        const SizedBox(
                            height: 6.0), // Agregar espacio entre los textos
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,

                          width: 85.0, // Ancho fijo del código QR
                          child: QrWidget(
                            data: data,
                            //data: widget.mascotas[index].qrData,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Código QR de la mascota (debes generar el código QR)
                    // Puedes usar un paquete como qr_flutter para generar el código QR
                    // Ejemplo: QrImage(data: 'código QR aquí'),
                    // Icono de botón para editar,
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Acción cuando se presiona el botón de editar
                        // Puedes abrir una pantalla de edición o ejecutar alguna otra lógica aquí
                      },
                    ),
                  ],
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
