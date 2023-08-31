import 'package:app_movil/widgets/main_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BungeeQR',
      //theme: ThemeData(
      //  primaryColor: Color.fromARGB(255, 93, 14, 211),
      //),
      initialRoute: MainWidget.routeName,
      routes: {
        MainWidget.routeName: (context) => const MainWidget(),
      },
    );
  }
}
