import 'package:flutter/material.dart';
import 'profile_setup_header.dart';
import 'username_input.dart';
import 'profile_picture_section.dart';
import 'submit_button.dart';

class ProfileSetupForm extends StatelessWidget {
  const ProfileSetupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        const ProfileSetupHeader(),
        const SizedBox(height: 24),
        
        // Username input
        const UsernameInput(),
        const SizedBox(height: 24),
        
        // Profile picture selection
        const ProfilePictureSection(),
        const SizedBox(height: 24),
        
        // Submit button
        const SubmitButton(),
      ],
    );
  }
}