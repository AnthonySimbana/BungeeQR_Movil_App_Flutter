import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_movil/widgets/reusable_widget.dart';
import 'package:app_movil/widgets/main_widget.dart';
import 'package:app_movil/utils/color_utils.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();

  String _errorMessage = ""; // Variable para mostrar mensajes de error

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("0ab4e4"),
              hexStringToColor("130d90"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const Text(
                  "Regístrate",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Ingresa tu nombre",
                  Icons.person_outline,
                  false,
                  _userNameTextController,
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Ingresa tu correo electronico",
                  Icons.mail,
                  false,
                  _emailTextController,
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Ingresa tu celular",
                  Icons.phone,
                  false,
                  _phoneTextController,
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Ingresa tu contraseña",
                  Icons.lock_outlined,
                  true,
                  _passwordTextController,
                ),
                const SizedBox(height: 20),
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
                firebaseUIButton(context, "Crear cuenta", () {
                  if (_userNameTextController.text.isEmpty ||
                      _emailTextController.text.isEmpty ||
                      _passwordTextController.text.isEmpty ||
                      _passwordTextController.text.isEmpty) {
                    setState(() {
                      _errorMessage = "Por favor, completa todos los campos.";
                    });
                    return;
                  }

                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text,
                  )
                      .then((value) {
                    print("Nueva cuenta creada");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainWidget()),
                    );
                  }).onError((error, stackTrace) {
                    setState(() {
                      _errorMessage = "Error: ${error.toString()}";
                    });
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
