import 'package:app_movil/screens/mascota/mascota_details_screen.dart';
import 'package:app_movil/screens/mascota/mascota_screen.dart';
import 'package:app_movil/screens/noticia/noticias_screen.dart';
import 'package:app_movil/screens/perfil_screen.dart';
import 'package:app_movil/screens/mascota/registrar_mascota_screen.dart';
import 'package:flutter/material.dart';

import '../screens/scaneer_qr_screen.dart';
import '../utils/color_utils.dart';
import 'nav_bar.dart';

class MainWidget extends StatefulWidget {
  static const routeName = '/main';

  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

//Definicion de 5 pantallas principales existentes
class _MainWidgetState extends State<MainWidget> {
  int _selectedIndex = 0;

  final List<Widget> _mainWidgets = [
    const NoticiaScreen(),
    const MascotaScreen(),
    RegistrarMascotaScreen(),
    ScannerScreen(),
    UserProfileScreen()
  ];

  final List<String> _titles = const [
    'Noticias',
    'Mis Mascotas',
    'Agregar Mascota',
    'Escanear QR',
    'Mi perfil'
  ];

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: hexStringToColor('#4A43EC'),
        title: Text(_titles[_selectedIndex]),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft:
                Radius.circular(50.0), // Ajusta el radio según tus necesidades
            bottomRight:
                Radius.circular(50.0), // Ajusta el radio según tus necesidades
          ),
        ),
      ),
      body: _mainWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: hexStringToColor('#4A43EC'),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Mascotas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onTapItem,
      ),
    );
  }
}
