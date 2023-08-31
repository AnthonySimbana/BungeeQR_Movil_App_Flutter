import 'package:flutter/material.dart';

class MascotasScreen extends StatefulWidget {
  const MascotasScreen({super.key});

  @override
  State<MascotasScreen> createState() => _MascotasScreenState();
}

class _MascotasScreenState extends State<MascotasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mascotas'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Esta es la pantalla para visualizar el listado de mascotas del usuario',
            )
          ],
        ),
      ),
    );
  }
}
