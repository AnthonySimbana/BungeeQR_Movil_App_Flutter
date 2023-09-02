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
          padding: const EdgeInsets.all(3.0), //espacio entre cada elementos
          child: GestureDetector(
            onTap: () => {
              Navigator.pushNamed(context, MascotaDetailsScreen.routeName,
                  arguments: widget.mascotas[index]
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
                      child: Image.network(
                        'http://placekitten.com/200/300',
                        fit: BoxFit.cover,
                        repeat: ImageRepeat.noRepeat
                      ),
                    ),
                ),
                
                title: Text('Nombre: ${widget.mascotas[index].nombre}'),
                subtitle: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [         
                      Text('Tipo: ${widget.mascotas[index].especie}'),
                      Text('Sexo: ${widget.mascotas[index].genero}'),
                      Text('Edad: ${widget.mascotas[index].edad}'),
                    ]
                  ), 
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Código QR de la mascota (debes generar el código QR)
                    // Puedes usar un paquete como qr_flutter para generar el código QR
                    // Ejemplo: QrImage(data: 'código QR aquí'),
                    // Icono de botón para editar,
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
          ),
        ),

        );
      },
              
      itemCount: widget.mascotas.length,
    );
  }
}
