//import 'dart:ffi';

import 'package:flutter/material.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
  );
}

//Definicion de un estilo de tipo TextField reutilizable
TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

//Definicion de un estilo de tipo TextFormField reutilizable
TextFormField reusableTextFormField(
  String text,
  IconData icon,
  TextEditingController controller,
  bool isEditing,
  String? Function(String?)? validator,
  TextInputType? keybiardType,
) {
  return TextFormField(
    controller: controller,
    readOnly: !isEditing,
    cursorColor: Colors.grey[350],
    style: TextStyle(color: Colors.grey.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.grey[600],
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      filled: true,
      fillColor: isEditing ? Colors.white : Colors.grey.withOpacity(0.3),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          width: 1,
          color: isEditing
              ? Colors.grey.withOpacity(1)
              : Colors.grey.withOpacity(0.5),
          style: BorderStyle.solid,
        ),
      ),
    ),
    //onSaved: onSaved,
    validator: validator,
    keyboardType: keybiardType,
  );
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    //margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    //decoration: BoxDecoration(
    // borderRadius: BorderRadius.circular(20),
    // color: Colors.purple,
    //),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.purple[700];
            }
            return Colors.purple;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
      child: Text(
        title, // Texto en mayúsculas
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

Container noPressedButton(BuildContext context, String title, Function onTap,
    [IconData? iconData]) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    //margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    //decoration: BoxDecoration(
    //borderRadius: BorderRadius.circular(30), // Borde redondeado
    //color: Colors.white, // Fondo blanco
    //border: Border.all(color: Colors.purple), // Borde morado
    //),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          }
          return Colors.white;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            // Borde morado

            side: const BorderSide(
              color: Colors.purple,
              width: 1,
            ),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconData != null) // Verifica si se proporcionó un ícono
            Icon(
              iconData,
              color: Colors.purple,
            ),
          const SizedBox(width: 8), // Espacio entre el icono y el texto
          Text(
            title,
            style: const TextStyle(
              color: Colors.purple, // Color del texto morado
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}
