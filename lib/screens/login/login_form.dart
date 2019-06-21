import 'package:bloc_complex/bloc/login/login_bloc.dart';
import 'package:bloc_complex/bloc/login/login_provider.dart';
import 'package:bloc_complex/bloc/login/login_state.dart';
import 'package:bloc_complex/screens/login/google_login_button.dart';
import 'package:bloc_complex/screens/login/login_button.dart';
import 'package:bloc_complex/screens/product/product_screen.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm();

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc loginBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    loginBloc = LoginProvider.of(context);
    loginBloc.loginStateStream.listen((onData) {
      if (onData.isSuccess) {
        Navigator.of(context).pushNamed(ProductScreen.routeName);
      }
    });
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: StreamBuilder<LoginState>(
        stream: loginBloc.loginStateStream,
        initialData: loginBloc.loginStateStream.value,
        builder: (context, snapshot) {
          if (snapshot.data.isSubmitting) {
            return Center(
              child: const CircularProgressIndicator(),
            );
          } else {
            return Form(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Image.asset('assets/flutter_logo.png', height: 200),
                  ),
                  StreamBuilder<LoginState>(
                    stream: loginBloc.loginStateStream,
                    initialData: loginBloc.loginStateStream.value,
                    builder: (context, snapshot) => TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            labelText: 'Email',
                          ),
                          autovalidate: true,
                          autocorrect: false,
                          validator: (_) {
                            return !snapshot.data.isEmailValid
                                ? 'Invalid Email'
                                : null;
                          },
                        ),
                  ),
                  StreamBuilder<LoginState>(
                    stream: loginBloc.loginStateStream,
                    initialData: loginBloc.loginStateStream.value,
                    builder: (context, snapshot) => TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          autovalidate: true,
                          autocorrect: false,
                          validator: (_) {
                            return !snapshot.data.isPasswordValid
                                ? 'Invalid Password'
                                : null;
                          },
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        StreamBuilder<LoginState>(
                          stream: loginBloc.loginStateStream,
                          initialData: loginBloc.loginStateStream.value,
                          builder: (context, snapshot) => LoginButton(
                                onPressed:
                                    snapshot.data.isFormValid && isPopulated
                                        ? _onFormSubmitted
                                        : null,
                              ),
                        ),
                        GoogleLoginButton(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    loginBloc.emailValidateSink.add(_emailController.text);
  }

  void _onPasswordChanged() {
    loginBloc.passwordValidateSink.add(_passwordController.text);
  }

  void _onFormSubmitted() {
    loginBloc.loginRequestSink
        .add(LoginRequest(_emailController.text, _passwordController.text));
  }
}
