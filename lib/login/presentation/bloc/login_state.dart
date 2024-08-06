import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String emailError;
  final String pwdError;

  bool get isEmailValid => email.contains('@') && email.contains('.');
  bool get isPasswordValid => password.length > 6;
  LoginState({
    required this.email,
    required this.password,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.emailError = '',
    this.pwdError = '',
  });

  factory LoginState.initial() {
    return LoginState(
      email: '',
      password: '',
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      emailError: '',
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? emailError,
    String? pwdError,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      emailError: emailError ?? this.emailError,
      pwdError: pwdError ?? this.pwdError,
    );
  }

  @override
  List<Object> get props => [email, password, isSubmitting, isSuccess, isFailure, emailError,pwdError];
}
