part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginRequested extends LoginEvent {
  const LoginRequested({
    required this.userName,
    required this.password,
  });

  final String userName;
  final String password;
}
