import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/ProfilePicture_Cubit/profile_picture_cubit.dart';
import '../../bloc/ProfilePicture_Cubit/profile_picture_state.dart';
import '../../bloc/ProfileSetup_Cubit/profile_setup_cubit.dart';
import '../../bloc/ProfileSetup_Cubit/profile_setup_state.dart';
import '../../themes/firefly_theme.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      builder: (context, state) {
        return BlocBuilder<ProfilePictureCubit, ProfilePictureState>(
          builder: (context, pictureState) {
            return ElevatedButton(
              onPressed: state.isSubmitting 
                ? null 
                : () => context.read<ProfileSetupCubit>().submitProfile(pictureState),
              style: ElevatedButton.styleFrom(
                backgroundColor: FireflyTheme.turquoise,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                disabledBackgroundColor: FireflyTheme.turquoise.withOpacity(0.5),
              ),
              child: state.isSubmitting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Complete Setup',
                      style: TextStyle(fontSize: 16),
                    ),
            );
          },
        );
      },
    );
  }
}