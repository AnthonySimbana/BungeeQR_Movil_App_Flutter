import 'package:flutter/material.dart';

class AddImagenWidget extends StatefulWidget {
  final String imageUrl;
  final IconData icon; // Agrega este atributo

  AddImagenWidget({required this.imageUrl, required this.icon});

  @override
  _AddImagenWidget createState() => _AddImagenWidget();
}

class _AddImagenWidget extends State<AddImagenWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: CircleAvatar(
            backgroundImage: NetworkImage(widget.imageUrl),
            radius: 60.0,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.purple,
            ),
            child: Icon(
              widget.icon, // Utiliza el ícono especificado
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
