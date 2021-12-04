import 'package:flutter/material.dart';
import 'package:flutter_sanctum/providers/auth.dart';
import 'package:flutter_sanctum/screen/login_screen.dart';
import 'package:flutter_sanctum/screen/posts_screen.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Consumer<Auth>(
      builder: (context, auth, child) {
        if (auth.authenticated) {
          return ListView(
            children: [
              ListTile(
                title: Text(auth.user.name),
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
                title: const Text('Logout'),
                onTap: () {
                  Provider.of<Auth>(context, listen: false).logout();
                },
              )
            ],
          );
        } else {
          return ListView(
            children: [
              ListTile(
                title: const Text('Login'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ),
              ListTile(
                title: const Text('Register'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ),
            ],
          );
        }
      },
    ));
  }
}
