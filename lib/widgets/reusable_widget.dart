//import 'dart:ffi';

import 'package:app_movil/utils/color_utils.dart';
import 'package:date_format/date_format.dart';
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
    cursorColor: Colors.blue,
    style: TextStyle(color: Colors.black87.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide:
            BorderSide(width: 0.5, color: Colors.white70.withOpacity(0.1)),
        //borderSide: const BorderSide(width: 0, style: BorderStyle.none)
      ),
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
        color: Colors.grey,
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
              return AppColors.primaryColor;
            }
            return const Color.fromRGBO(86, 105, 255, 255).withOpacity(0.9);
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

            side: BorderSide(
              color: AppColors.primaryColor,
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
              color: AppColors.primaryColor,
            ),
          const SizedBox(width: 8), // Espacio entre el icono y el texto
          Text(
            title,
            style: TextStyle(
              color: AppColors.primaryColor, // Color del texto morado
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}

//Definicion de un estilo de tipo TextFormField reutilizable fecha
TextFormField reusableTextFormFieldDate(
  String text,
  IconData icon,
  TextEditingController controller,
  bool isEditing,
  String? Function(String?)? validator,
  BuildContext
      context, // Necesitas el contexto para mostrar el selector de fecha
) {
  return TextFormField(
    controller: controller,
    readOnly: true, // El campo de fecha es de solo lectura
    cursorColor: Colors.grey[350],
    style: TextStyle(color: Colors.grey.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.grey,
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
      suffixIcon: isEditing
          ? IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );

                if (selectedDate != null) {
                  final formattedDate = formatDate(
                    selectedDate,
                    [dd, '/', mm, '/', yyyy],
                  );
                  controller.text = formattedDate;
                }
              },
            )
          : null, // No mostrar el ícono si no estás editando
    ),
    //onSaved: onSaved,
    validator: validator,
    keyboardType: TextInputType.datetime, // Cambiar el tipo de teclado
  );
}

TextFormField reusableTextFormFieldTime(
  String text,
  IconData icon,
  TextEditingController controller,
  bool isEditing,
  String? Function(String?)? validator,
  BuildContext
      context, // Necesitas el contexto para mostrar el selector de hora
) {
  return TextFormField(
    controller: controller,
    readOnly: true, // El campo de hora es de solo lectura
    cursorColor: Colors.grey[350],
    style: TextStyle(color: Colors.grey.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.grey,
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
      suffixIcon: isEditing
          ? IconButton(
              icon: Icon(Icons.access_time),
              onPressed: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (selectedTime != null) {
                  final formattedTime =
                      "${selectedTime.hour}:${selectedTime.minute}";
                  controller.text = formattedTime;
                }
              },
            )
          : null, // No mostrar el ícono si no estás editando
    ),
    //onSaved: onSaved,
    validator: validator,
    keyboardType: TextInputType.datetime, // Cambiar el tipo de teclado
  );
}
