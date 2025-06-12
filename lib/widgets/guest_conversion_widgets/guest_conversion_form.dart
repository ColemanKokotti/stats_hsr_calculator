import 'package:flutter/material.dart';
import 'guest_conversion_header.dart';
import 'error_message_display.dart';
import 'email_input.dart';
import 'password_input.dart';
import 'confirm_password_input.dart';
import 'action_buttons.dart';

class GuestConversionForm extends StatelessWidget {
  const GuestConversionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header and description
        const GuestConversionHeader(),
        const SizedBox(height: 32),
        
        // Error message
        const ErrorMessageDisplay(),
        
        // Email input
        const EmailInput(),
        const SizedBox(height: 16),
        
        // Password input
        const PasswordInput(),
        const SizedBox(height: 16),
        
        // Confirm password input
        const ConfirmPasswordInput(),
        const SizedBox(height: 32),
        
        // Action buttons
        const ActionButtons(),
      ],
    );
  }
}