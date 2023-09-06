import 'package:app_movil/providers/usuario_provider.dart';
import 'package:app_movil/screens/login/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String _userName = 'Ronny Santos';
  String _userEmail = 'example@gmail.com';
  String _userImageUrl =
      'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png';

  _inicializarInformacion() {
    final userProvider = Provider.of<UsuarioProvider>(context);
    _userName = userProvider.getNombreUsuario();
    _userEmail = userProvider.getCorreoUsuario();
    _userImageUrl = userProvider.getImagenUrlUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          FutureBuilder(
            future: Provider.of<UsuarioProvider>(context, listen: false)
                .checkUsuario(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return Text('Error o usuario no autenticado');
              }
              final user = snapshot.data!;
              _inicializarInformacion();

              return UserAccountsDrawerHeader(
                accountName: Text(_userName),
                accountEmail: Text(_userEmail),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      _userImageUrl,
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF4A43EC),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/fondoNavBar.jpg'),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Friends'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () {},
          ),
          const ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Request'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Policies'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app_sharp,
              color: Colors.purple,
            ),
            title: const Text(
              'Exit',
              style: TextStyle(
                color: Colors.purple,
              ),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
