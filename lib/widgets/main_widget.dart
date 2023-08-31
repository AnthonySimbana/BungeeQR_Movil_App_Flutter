import 'package:app_movil/screens/mascotas_screen.dart';
import 'package:app_movil/screens/noticias_screen.dart';
import 'package:app_movil/screens/perfil_screen.dart';
import 'package:app_movil/screens/registrar_mascota_screen.dart';
import 'package:app_movil/screens/scanner_qr_screen.dart';
import 'package:flutter/material.dart';

class MainWidget extends StatefulWidget {
  static const routeName = '/';

  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

//Definicion de 5 pantallas principales existentes
class _MainWidgetState extends State<MainWidget> {
  int _selectedIndex = 0;

  final List<Widget> _mainWidgets = const [
    NoticiasScreen(),
    MascotasScreen(),
    RegistrarMascotaScreen(),
    ScannerScreen(),
    PerfilScreen()
  ];

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Mascotas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: '+',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Perfil',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onTapItem,
      ),
    );
  }
}
