import 'package:bloc/bloc.dart';
import '../../domain/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginState.initial()){
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, emailError: ''));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<LoginSubmitted>((event, emit) async {
      if (state.password.isEmpty && state.email.isEmpty) {
        emit(state.copyWith(
            emailError: 'Enter valid email.', pwdError: 'Enter valid pwd'));
      }
      if (!state.isEmailValid) {
        emit(state.copyWith(emailError: 'Invalid Email'));
      } else if (state.isEmailValid && state.password.isNotEmpty) {
        emit(state.copyWith(isSubmitting: true));
        try {
          final isSuccess =
          await loginUseCase.execute(state.email, state.password);
          print('inside isSuccess $isSuccess');
          if (isSuccess) {
            emit(state.copyWith(isSuccess: true, isSubmitting: false));
          } else {
            emit(state.copyWith(isFailure: true, isSubmitting: false));
          }
        } catch (_) {
          emit(state.copyWith(isFailure: true, isSubmitting: false));
        }

      } else {
        emit(state.copyWith(isFailure: true));
      }
    });

  }

}
