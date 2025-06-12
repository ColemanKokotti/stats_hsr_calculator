import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Auth_Cubit/auth_cubit.dart';
import '../Auth_Cubit/auth_state.dart';
import 'guest_conversion_state.dart';

class GuestConversionCubit extends Cubit<GuestConversionState> {
  final FirebaseAuth _auth;
  final AuthCubit _authCubit;

  GuestConversionCubit({
    required FirebaseAuth auth,
    required AuthCubit authCubit,
  })  : _auth = auth,
        _authCubit = authCubit,
        super(GuestConversionState.initial());

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void updateConfirmPassword(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void resetForm() {
    emit(GuestConversionState.initial());
  }

  Future<void> convertGuestAccount() async {
    // Validate inputs
    if (state.email.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter an email address'));
      return;
    }

    if (state.password.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter a password'));
      return;
    }

    if (state.password != state.confirmPassword) {
      emit(state.copyWith(errorMessage: 'Passwords do not match'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      // Get current user
      final user = _auth.currentUser;
      
      if (user == null || !user.isAnonymous) {
        emit(state.copyWith(
          errorMessage: 'No guest account is currently signed in',
          isSubmitting: false,
        ));
        return;
      }

      // Create credential
      final credential = EmailAuthProvider.credential(
        email: state.email.trim(),
        password: state.password,
      );

      // Link the anonymous account with the email credential
      final result = await user.linkWithCredential(credential);
      
      // Update the auth state by emitting a new AuthAuthenticated state
      if (result.user != null) {
        // The user is now a registered user (not anonymous anymore)
        _authCubit.emit(AuthAuthenticated(user: result.user!));
        
        // Emit success state
        emit(state.copyWith(isSuccess: true, isSubmitting: false));
      }
    } catch (e) {
      print('Error converting guest account: $e');
      emit(state.copyWith(
        errorMessage: 'Failed to convert account: ${e.toString()}',
        isSubmitting: false,
      ));
    }
  }
}