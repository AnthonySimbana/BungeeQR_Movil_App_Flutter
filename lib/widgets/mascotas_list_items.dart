import 'package:flutter/material.dart';
import 'package:app_movil/widgets/qr_widget.dart'; // Asegúrate de importar el widget QrWidget
import 'package:qr_flutter/qr_flutter.dart';
import '../dtos/mascota_model.dart';
import '../screens/mascota/mascota_details_screen.dart';

class MascotaListItems extends StatefulWidget {
  final List<Mascota> mascotas;
  const MascotaListItems({super.key, required this.mascotas});

  @override
  State<MascotaListItems> createState() => _MascotaListItemsState();
}

class _MascotaListItemsState extends State<MascotaListItems> {

  final String data = "http://placekitten.com/200/300";

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
                  leading: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network('http://placekitten.com/200/300',
                          fit: BoxFit.cover, repeat: ImageRepeat.noRepeat),
                    ),
                    
                  ),

                  title: Padding(
                    padding: const EdgeInsets.only(top: 8.0), // Ajusta el padding del título aquí
                    child: Text('Nombre: ${widget.mascotas[index].nombre}'),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tipo: ${widget.mascotas[index].especie}'),
                          const SizedBox(height: 6.0), // Agregar espacio entre los textos
                          Text('Sexo: ${widget.mascotas[index].genero}'),
                          const SizedBox(height: 6.0), // Agregar espacio entre los textos
                          Text('Edad: ${widget.mascotas[index].edad}'),
                        ],
                      ),
                      Container(
                        width: 80.0, // Ancho fijo del código QR
                        child: QrWidget(
                          data: data,
                          //data: widget.mascotas[index].qrData,
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [               
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Acción cuando se presiona el botón de editar
                          // Puedes abrir una pantalla de edición o ejecutar alguna otra lógica aquí
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
      itemCount: widget.mascotas.length,
    );
  }
}
