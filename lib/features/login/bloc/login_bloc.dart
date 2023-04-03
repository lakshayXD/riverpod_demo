import 'package:infinity_box_task/features/login/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _repo;

  LoginBloc(this._repo) : super(const LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  void _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    try {
      String accessToken = await _repo.logInUser(
        userName: event.userName,
        password: event.password,
      );
      emit(LoginSuccess(token: accessToken));
    } catch (e) {
      emit(LoginFailure(e.toString()));
      addError(e);
    }
  }
}
