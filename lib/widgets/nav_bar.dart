import 'package:app_movil/screens/login/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              // Remove padding
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: const Text('Ronny Santos'),
                  accountEmail: const Text('example@gmail.com'),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                  ),
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
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'Exit',
              style: TextStyle(
                  color: Colors.white), // Cambiar color del texto a blanco
            ),
            leading: const Icon(Icons.exit_to_app,
                color: Colors.white), // Cambiar color del ícono a blanco
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
              );
            },
            tileColor: Colors.blue.shade200, // Cambiar color de fondo
          )
        ],
      ),
    );
  }
}
