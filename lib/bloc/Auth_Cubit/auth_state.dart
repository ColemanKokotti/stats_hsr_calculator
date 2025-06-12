// lib/bloc/Auth_Cubit/auth_state.dart
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  final bool isGuest;
  // Add these fields to store user data separately
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;

  AuthAuthenticated({
    required this.user,
    this.isGuest = false,
  }) : uid = user.uid,
       email = user.email,
       displayName = user.displayName,
       photoURL = user.photoURL;

  @override
  List<Object?> get props => [uid, isGuest, email, displayName, photoURL];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthRegistrationSuccess extends AuthState {
  final String message;

  const AuthRegistrationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}