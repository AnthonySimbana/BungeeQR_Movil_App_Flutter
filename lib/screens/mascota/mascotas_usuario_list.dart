import 'package:app_movil/dtos/mascota_model.dart';
import 'package:app_movil/widgets/mascotas_list_items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class MascotasUsuarioList extends StatefulWidget {
  const MascotasUsuarioList({super.key});

  @override
  State<MascotasUsuarioList> createState() => _MascotasUsuarioListState();
}

class _MascotasUsuarioListState extends State<MascotasUsuarioList> {
  late Stream<QuerySnapshot>
      _queryStream; //Aqui el snapshot para consuutar a un campo interno de un documento, puede retornar uno o VARIOS documentos
  //Aqui recibe notificaciones un REALTIME y actualiza la app
  @override
  void initState() {
    var db = FirebaseFirestore.instance;
    _queryStream = db
        .collection('mascotas')
        .where('idUser', isEqualTo: '1')
        .withConverter<Mascota>(
            //Aqui hace la llamada de conversion de documentos a un tipo de dato
            fromFirestore: (snapshot, _) =>
                Mascota.fromFirebaseJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: _queryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              //Transforma los datos de la consulta del query en Mascotas
              List<Mascota> Mascotas =
                  snapshot.data!.docs.map((e) => e.data() as Mascota).toList();
              //docs lista de elementos asociados al query
              return MascotaListItems(mascotas: Mascotas);
            }));
  }
}

/*SnapShot tiene
      Data
        docs() -> Arreglo 
          maps (-> doc -data -> Mascota)
            toList()

*/
