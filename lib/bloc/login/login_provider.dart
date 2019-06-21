import 'package:bloc_complex/bloc/login/login_bloc.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';

@immutable
class LoginProvider extends BlocProvider<LoginBloc> {
  LoginProvider({
    Widget child,
  }) : super(
          creator: (context, _bag) => LoginBloc(),
          child: child,
        );

  static LoginBloc of(BuildContext context) => BlocProvider.of(context);
}
