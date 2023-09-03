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

  String _emailErrorMessage = "";
  String _phoneErrorMessage = "";
  String _passwordErrorMessage = "";

  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

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
      Color(0xFF2196F3), // Azul claro
      Color(0xFF1976D2), // Azul medio
      Color(0xFF0D47A1), // Azul oscuro
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Ingresa tu nombre",
                    icon: Icon(Icons.person_outline),
                  ),
                  controller: _userNameTextController,
                ),
                const SizedBox(height: 10),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Ingresa tu correo electrónico",
                    icon: Icon(Icons.mail),
                  ),
                  controller: _emailTextController,
                ),
                const SizedBox(height: 10),
                Text(
                  _emailErrorMessage,
                  style: TextStyle(color: Colors.red),
                ),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Ingresa tu celular",
                    icon: Icon(Icons.phone),
                  ),
                  controller: _phoneTextController,
                ),
                Text(
                  _phoneErrorMessage,
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 10),
                
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Ingresa tu contraseña",
                    icon: Icon(Icons.lock_outlined),
                  ),
                  obscureText: true,
                  controller: _passwordTextController,
                ),
                Text(
                  _passwordErrorMessage,
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 20),
                firebaseUIButton(context, "Crear cuenta", () {
                  // Validaciones y registro de usuario
                  if (_userNameTextController.text.isEmpty ||
                      _emailTextController.text.isEmpty ||
                      _phoneTextController.text.isEmpty ||
                      _passwordTextController.text.isEmpty) {
                    setState(() {
                      _emailErrorMessage = "";
                      _phoneErrorMessage = "";
                      _passwordErrorMessage = "Por favor, completa todos los campos.";
                    });
                    return;
                  }

                  if (!emailRegex.hasMatch(_emailTextController.text)) {
                    setState(() {
                      _emailErrorMessage = "Por favor, ingresa un correo electrónico válido.";
                      _phoneErrorMessage = "";
                      _passwordErrorMessage = "";
                    });
                    return;
                  }

                  if (_phoneTextController.text.length != 10) {
                    setState(() {
                      _emailErrorMessage = "";
                      _phoneErrorMessage = "Por favor, ingresa un número de celular válido (10 dígitos).";
                      _passwordErrorMessage = "";
                    });
                    return;
                  }

                  // Resto del código de registro
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
                      })
                      .onError((error, stackTrace) {
                        setState(() {
                          _emailErrorMessage = "";
                          _phoneErrorMessage = "";
                          _passwordErrorMessage = "Error: ${error.toString()}";
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
