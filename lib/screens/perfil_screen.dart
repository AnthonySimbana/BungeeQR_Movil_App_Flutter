import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String nombre;
  final String telefono;
  final String correo;
  final String imageUrl;

  UserProfile({
    required this.uid,
    required this.nombre,
    required this.telefono,
    required this.correo,
    required this.imageUrl,
  });
}

class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          UserProfile userProfile = UserProfile(
            uid: user.uid,
            nombre: snapshot.data!['nombre'],
            telefono: snapshot.data!['telefono'],
            correo: snapshot.data!['correo'],
            imageUrl: snapshot.data!['imageUrl'],
          );

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Nombre: ${userProfile.nombre}'),
              Text('Telefono: ${userProfile.telefono}'),
              Text('Correo: ${userProfile.correo}'),
            ],
          );
        },
      );
    } else {
      return Text('Usuario no autenticado');
    }
  }
}
