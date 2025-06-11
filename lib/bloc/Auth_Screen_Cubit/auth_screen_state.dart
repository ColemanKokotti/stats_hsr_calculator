import 'package:equatable/equatable.dart';

class AuthScreenState extends Equatable {
  final bool isLogin;
  final int animationKey;

  const AuthScreenState({
    this.isLogin = true,
    this.animationKey = 0,
  });

  AuthScreenState copyWith({
    bool? isLogin,
    int? animationKey,
  }) {
    return AuthScreenState(
      isLogin: isLogin ?? this.isLogin,
      animationKey: animationKey ?? this.animationKey,
    );
  }

  @override
  List<Object> get props => [isLogin, animationKey];
}
