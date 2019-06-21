import 'package:bloc_complex/screens/login/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen();

  static const routeName = '/login';
  static const title = Text('Login');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      body: const LoginForm(),
    );
  }
}
