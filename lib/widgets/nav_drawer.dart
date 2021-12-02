import 'package:flutter/material.dart';
import 'package:flutter_sanctum/screen/login_screen.dart';
import 'package:flutter_sanctum/screen/posts_screen.dart';

class  NavDrawer extends StatelessWidget{
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const ListTile(
            title: Text('Equipo 7'),
          ),
          ListTile(
            title: const Text('Posts'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostsScreen()));
            },
          ),
          ListTile(
            title: const Text('Login'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}