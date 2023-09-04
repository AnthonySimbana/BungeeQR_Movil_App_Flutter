import 'package:flutter/material.dart';

class AddImagenWidget extends StatefulWidget {
  final String imageUrl;

  AddImagenWidget({required this.imageUrl});

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
            child: const Icon(Icons.edit, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }
}
