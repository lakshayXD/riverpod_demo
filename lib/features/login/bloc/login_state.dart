part of 'login_bloc.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final String token;
  const LoginSuccess({required this.token});
}

class LoginFailure extends LoginState {
  final String err;
  const LoginFailure(this.err);
}
