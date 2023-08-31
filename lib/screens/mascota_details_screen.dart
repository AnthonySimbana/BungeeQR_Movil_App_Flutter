import 'package:flutter/material.dart';

class MascotaDetailsScreen extends StatelessWidget {
  const MascotaDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Mi Mascota'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Esta es la pantalla de detalles de una mascota seleccionada',
            )
          ],
        ),
      ),
    );
  }
}
