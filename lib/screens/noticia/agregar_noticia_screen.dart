import 'package:flutter/material.dart';

class AgregarNoticiaScreen extends StatefulWidget {
  const AgregarNoticiaScreen({super.key});

  @override
  State<AgregarNoticiaScreen> createState() => _AgregarNoticiaScreenState();
}

class _AgregarNoticiaScreenState extends State<AgregarNoticiaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Esta es la pantalla para agregar noticias',
            )
          ],
        ),
      ),
    );
  }
}
