import 'package:app_movil/providers/moscota_provider.dart';
import 'package:app_movil/providers/noticia_provider.dart';
import 'package:app_movil/screens/login/signin_screen.dart';
import 'package:app_movil/screens/mascota/mascota_details_screen.dart';
import 'package:app_movil/screens/noticia/noticia_details_screen.dart';
import 'package:app_movil/widgets/main_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Para inicializar instancias primero como firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MascotaProvider()),
        ChangeNotifierProvider(create: (context) => NoticiaProvider()),
      ],
      child: MaterialApp(
        title: 'BungeeQR',
        home: const AuthenticationWrapper(),

        //initialRoute: MainWidget.routeName,
        routes: {
          MainWidget.routeName: (context) => const MainWidget(),
          MascotaDetailsScreen.routeName: (context) =>
              const MascotaDetailsScreen(),
          NoticiaDetailsScreen.routeName: (context) =>
              const NoticiaDetailsScreen(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Verificar el estado de autenticación aquí (puedes usar Firebase Auth o cualquier otro método)
    // Si el usuario está autenticado, regresa MainWidget
    // Si el usuario no está autenticado, regresa SignInScreen
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    if (user != null) {
      // Si el usuario está autenticado, regresa MainWidget
      return const MainWidget();
    } else {
      // Si el usuario no está autenticado, regresa SignInScreen
      return SignInScreen();
    }
  }
}

