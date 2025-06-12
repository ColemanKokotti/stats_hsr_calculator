import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/Profile_Cubit/profile_cubit.dart';
import '../bloc/Profile_Cubit/profile_state.dart';
import '../bloc/ProfilePicture_Cubit/profile_picture_cubit.dart';
import '../bloc/ProfileSetup_Cubit/profile_setup_cubit.dart';
import '../bloc/ProfileSetup_Cubit/profile_setup_state.dart';
import '../data/profile_pictures_data.dart';
import '../themes/firefly_theme.dart';
import '../widgets/profile_setup_widgets/profile_setup_form.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfilePictureCubit(
            allProfilePictures: ProfilePicturesData.allProfilePictures,
            itemsPerPage: ProfilePicturesData.defaultItemsPerPage,
          ),
        ),
        BlocProvider(
          create: (context) => ProfileSetupCubit(
            profileCubit: context.read<ProfileCubit>(),
          ),
        ),
      ],
      child: BlocListener<ProfileSetupCubit, ProfileSetupState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        child: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              context.read<ProfileSetupCubit>().setSubmitting(false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is ProfileLoaded) {
              // Profile setup complete, navigate to home screen
              Navigator.of(context).pushReplacementNamed('/navigation');
            }
          },
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(gradient: FireflyTheme.backgroundGradient),
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 500, // Limita la larghezza massima per un migliore layout
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                        child: ProfileSetupForm(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}