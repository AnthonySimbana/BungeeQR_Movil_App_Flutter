import 'package:flutter/material.dart';

class NoticiasScreen extends StatefulWidget {
  const NoticiasScreen({super.key});

  @override
  State<NoticiasScreen> createState() => _NoticiasScreenState();
}

class _NoticiasScreenState extends State<NoticiasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Noticias'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Esta es la pantalla para visualizar el listado de noticias existentes',
            )
          ],
        ),
      ),
    );
  }
}
