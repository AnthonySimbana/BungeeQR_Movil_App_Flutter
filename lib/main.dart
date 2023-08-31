import 'package:app_movil/widgets/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      initialRoute: MainWidget.routeName,
      routes: {
        MainWidget.routeName: (context) => const MainWidget(),
      },
    );
  }
}
