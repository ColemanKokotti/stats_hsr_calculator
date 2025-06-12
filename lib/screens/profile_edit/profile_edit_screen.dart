import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/ProfileEdit_Cubit/profile_edit_cubit.dart';
import '../../themes/firefly_theme.dart';
import 'widgets/edit_username_section.dart';
import 'widgets/edit_profile_picture_section.dart';
import 'widgets/edit_password_section.dart';
import 'widgets/delete_account_section.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileEditCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          backgroundColor: FireflyTheme.jacket,
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: FireflyTheme.backgroundGradient,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Your Profile',
                      style: TextStyle(
                        color: FireflyTheme.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Update your profile information below',
                      style: TextStyle(
                        color: FireflyTheme.white.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Edit sections
                    const EditUserNameSection(),
                    const SizedBox(height: 16),
                    const EditProfilePictureSection(),
                    const SizedBox(height: 16),
                    const EditPasswordSection(),
                    const SizedBox(height: 16),
                    const DeleteAccountSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}