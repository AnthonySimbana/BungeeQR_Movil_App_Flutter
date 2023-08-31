import 'package:flutter/material.dart';

class RegistrarMascotaScreen extends StatefulWidget {
  const RegistrarMascotaScreen({super.key});

  @override
  State<RegistrarMascotaScreen> createState() => _RegistrarMascotaScreenState();
}

class _RegistrarMascotaScreenState extends State<RegistrarMascotaScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Registrar mascota'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Esta es la pantalla para registrar una mascota',
            )
          ],
        ),
      ),
    );
  }
}
