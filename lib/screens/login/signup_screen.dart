import 'package:app_movil/providers/usuario_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_movil/widgets/reusable_widget.dart';
import 'package:app_movil/widgets/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  //final UsuarioProvider usuarioProvider;

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

  bool _verificarDatos() {
    if (_userNameTextController.text.isEmpty ||
        _emailTextController.text.isEmpty ||
        _passwordTextController.text.isEmpty ||
        _passwordTextController.text.isEmpty) {
      setState(() {
        _errorMessage = "Por favor, completa todos los campos.";
      });
      return false;
    } else {
      return true;
    }
  }

  crearPerfilUsuario(
      String? uid, String nombre, String mail, String phone, String imageUrl) {
    Provider.of<UsuarioProvider>(context, listen: false)
        .crearPerfilUsuario(uid, nombre, mail, phone, imageUrl);
  }

  crearCuenta(String email, String password) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 89, 73, 210)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo.png'),
            fit: BoxFit.cover,
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
                      color: Color.fromARGB(255, 89, 73, 210)),
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
                  if (_verificarDatos()) {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text,
                    )
                        .then((value) {
                      print("Nueva cuenta creada");

                      final FirebaseAuth _auth = FirebaseAuth.instance;
                      final User? user = _auth.currentUser;

                      String? uid = user?.uid;
                      print('Aqui deberia obtener mi uid: $uid ');

                      crearPerfilUsuario(
                          uid,
                          _userNameTextController.text,
                          _emailTextController.text,
                          _phoneTextController.text,
                          "http://placekitten.com/200/200");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainWidget()),
                      );
                    }).onError((error, stackTrace) {
                      setState(() {
                        _errorMessage = "Error: ${error.toString()}";
                        //The email address is badly formatted
                      });
                    });
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
