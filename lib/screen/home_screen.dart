import 'package:flutter/material.dart';
import 'package:flutter_sanctum/widgets/nav_drawer.dart';
import 'package:flutter_sanctum/providers/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final storage = FlutterSecureStorage();

  void _attemptAuthentication() async {
    final key = await storage.read(key: 'auth');
    Provider.of<Auth>(context, listen: false).attempt(key!);
  }

  @override
  void initState() {
    _attemptAuthentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const NavDrawer(),
      body: Center(child: Consumer<Auth>(
        builder: (context, auth, child) {
          if (auth.authenticated) {
            return const Text('You are logged in');
          } else {
            return const Text('You are not logged in');
          }
        },
      )),
    );
  }
}
