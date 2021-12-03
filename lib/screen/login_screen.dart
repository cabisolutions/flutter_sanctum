//import 'dart:developer';

//import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sanctum/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}


class LoginState extends State<LoginScreen>{
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void submit () {
    Provider.of<Auth>(context, listen:false ).login(
      credentials: {
        'email': _email,
        'password' : _password
      }
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child:SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  initialValue: 'equipo7@gmail.com',
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'you@somewhere.com', 
                  ),
                  onSaved: (value){
                    _email = value!;
                  },
                ),
                TextFormField(
                  initialValue: 'password',
                  decoration: const InputDecoration(
                    labelText: 'Password', 
                  ),
                  onSaved: (value){
                    _password = value!;
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton( //FlatButton se cambió por TextButton
                    onPressed: () {
                      _formKey.currentState!.save();

                     submit();
                    }, 
                   child: const Text('Login')
                  )
                )
              ],
            ),
          )
        )
      )
    );
  }
}