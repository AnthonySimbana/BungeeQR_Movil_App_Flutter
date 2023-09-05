import 'package:app_movil/screens/login/reset_password.dart';
import 'package:app_movil/screens/login/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_movil/widgets/reusable_widget.dart';
import 'package:app_movil/widgets/main_widget.dart';
import 'package:app_movil/utils/color_utils.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  void _signIn() async {
    if (_emailTextController.text.isEmpty ||
        _passwordTextController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Por favor, ingresa tu correo electrónico y contraseña.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Cerrar el cuadro de diálogo
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainWidget()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' ||
            e.code == 'wrong-password' ||
            e.code == 'invalid-email') {
          print("Credenciales incorrectas");
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text(
                    'Correo electronico y/o Contraseña Incorrectas. Por favor, intenta de nuevo.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Cerrar el cuadro de diálogo
                    },
                    child: const Text('Aceptar'),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.08,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                //logoWidget('assets/images/logoBungeeQR.png'),
                Image.asset(
                  'logoBungeeQR.png',
                  height: 100,
                ),
                Image.asset(
                  'nombreBungeeQR.png',
                  height: 50,
                ),
                const SizedBox(height: 30),
                reusableTextField(
                  "correo@ejemplo.com",
                  Icons.email,
                  false,
                  _emailTextController,
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Ingresa tu contraseña",
                  Icons.lock_outline,
                  true,
                  _passwordTextController,
                ),

                const SizedBox(height: 5),
                forgetPassword(context),
                firebaseUIButton(context, "Iniciar sesión", _signIn),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("No tienes una cuenta?",
            style: TextStyle(color: Colors.black)),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
          child: const Text(
            "Regístrate",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "¿Olvidaste tu contraseña?",
          style: TextStyle(
            color: Color(0xFF4A43EC),
            decoration: TextDecoration.underline,
          ),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPassword()),
        ),
      ),
    );
  }
}
