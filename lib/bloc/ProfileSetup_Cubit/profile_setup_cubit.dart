import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_setup_state.dart';
import '../Profile_Cubit/profile_cubit.dart';
import '../ProfilePicture_Cubit/profile_picture_state.dart';
import '../../data/profile_pictures_data.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupState> {
  final ProfileCubit profileCubit;

  ProfileSetupCubit({required this.profileCubit}) : super(ProfileSetupState.initial());

  void updateUsername(String username) {
    emit(state.copyWith(username: username));
  }

  void setSubmitting(bool isSubmitting) {
    emit(state.copyWith(isSubmitting: isSubmitting));
  }

  void setError(String? errorMessage) {
    emit(state.copyWith(errorMessage: errorMessage));
  }

  void submitProfile(ProfilePictureState pictureState) {
    // Validate form
    if (state.username.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter a username'));
      return;
    }

    if (pictureState.selectedProfilePicture.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please select a profile picture'));
      return;
    }

    // Set submitting state
    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    // Get values
    final username = state.username.trim();
    final profilePicture = ProfilePicturesData.getProfilePicturePath(pictureState.selectedProfilePicture);

    // Submit to profile cubit
    profileCubit.updateProfile(
      username: username,
      profilePicture: profilePicture,
    );
  }

  void resetForm() {
    emit(ProfileSetupState.initial());
  }
}