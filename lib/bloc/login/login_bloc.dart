import 'dart:async';

import 'package:bloc_complex/bloc/login/login_state.dart';
import 'package:bloc_complex/repository/user_repository.dart';
import 'package:bloc_complex/utils/validators.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class LoginRequest {
  final String email;
  final String password;

  const LoginRequest(this.email, this.password);
}

@immutable
class LoginBloc implements Bloc {
  final userRepository = UserRepository();

  final _loginRequestController = StreamController<LoginRequest>();
  final _emailValidateController = StreamController<String>();
  final _passwordValidateController = StreamController<String>();
  final _googleLoginController = StreamController();
  final _loginState = BehaviorSubject<LoginState>.seeded(LoginState.empty());

  LoginBloc() {
    _loginRequestController.stream.listen((login) async {
      try {
        await userRepository.signInWithCredentials(login.email, login.password);
        _loginState.add(LoginState.success());
      } catch (_) {
        _loginState.add(LoginState.failure());
      }
    });
    _emailValidateController.stream.listen((email) {
      final newState = _loginState.value
          .update(isEmailValid: Validators.isValidEmail(email));
      _loginState.add(newState);
    });
    _passwordValidateController.stream.listen((password) {
      final newState = _loginState.value
          .update(isPasswordValid: Validators.isValidPassword(password));
      _loginState.add(newState);
    });
    _googleLoginController.stream.listen((onData) async {
      try {
        _loginState.add(LoginState.loading());
        await userRepository.signOut();
        await userRepository.signInWithGoogle();
        _loginState.add(LoginState.success());
      } catch (_) {
        _loginState.add(LoginState.failure());
      }
    });
  }

  Sink<LoginRequest> get loginRequestSink => _loginRequestController.sink;
  Sink<String> get emailValidateSink => _emailValidateController.sink;
  Sink<String> get passwordValidateSink => _passwordValidateController.sink;
  Sink get googleLoginSink => _googleLoginController.sink;
  ValueObservable<LoginState> get loginStateStream => _loginState.stream;

  @override
  void dispose() {
    _loginRequestController.close();
    _emailValidateController.close();
    _passwordValidateController.close();
    _googleLoginController.close();
    _loginState.close();
  }
}
