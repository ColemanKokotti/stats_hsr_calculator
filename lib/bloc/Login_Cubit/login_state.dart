import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool obscurePassword;

  const LoginState({
    this.email = '',
    this.password = '',
    this.obscurePassword = true,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? obscurePassword,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }

  @override
  List<Object> get props => [email, password, obscurePassword];
}
