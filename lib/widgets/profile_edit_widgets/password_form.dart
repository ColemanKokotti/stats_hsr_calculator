import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/ProfileEdit_Cubit/profile_edit_cubit.dart';
import '../../bloc/ProfileEdit_Cubit/profile_edit_state.dart';
import '../../themes/firefly_theme.dart';
import 'password_input_field.dart';

class PasswordForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final bool obscureCurrentPassword;
  final bool obscureNewPassword;
  final bool obscureConfirmPassword;
  final VoidCallback onToggleCurrentPassword;
  final VoidCallback onToggleNewPassword;
  final VoidCallback onToggleConfirmPassword;
  final VoidCallback onUpdatePassword;

  const PasswordForm({
    super.key,
    required this.formKey,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.obscureCurrentPassword,
    required this.obscureNewPassword,
    required this.obscureConfirmPassword,
    required this.onToggleCurrentPassword,
    required this.onToggleNewPassword,
    required this.onToggleConfirmPassword,
    required this.onUpdatePassword,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditCubit, ProfileEditState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PasswordInputField(
                controller: currentPasswordController,
                labelText: 'Current Password',
                hintText: 'Enter your current password',
                obscureText: obscureCurrentPassword,
                onToggleVisibility: onToggleCurrentPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              PasswordInputField(
                controller: newPasswordController,
                labelText: 'New Password',
                hintText: 'Enter your new password',
                obscureText: obscureNewPassword,
                onToggleVisibility: onToggleNewPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              PasswordInputField(
                controller: confirmPasswordController,
                labelText: 'Confirm New Password',
                hintText: 'Confirm your new password',
                obscureText: obscureConfirmPassword,
                onToggleVisibility: onToggleConfirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state is ProfileEditLoading ? null : onUpdatePassword,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: FireflyTheme.turquoise,
                  ),
                  child: state is ProfileEditLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Update Password'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}