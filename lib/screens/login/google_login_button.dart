import 'package:bloc_complex/bloc/login/login_bloc.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of(context);
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      icon: Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () {
        loginBloc.googleLoginSink.add(null);
      },
      label: Text('Sign in with Google', style: TextStyle(color: Colors.white)),
      color: Colors.redAccent,
    );
  }
}
