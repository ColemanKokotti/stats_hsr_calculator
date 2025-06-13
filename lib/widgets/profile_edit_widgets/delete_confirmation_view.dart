import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/ProfileEdit_Cubit/profile_edit_cubit.dart';
import '../../bloc/ProfileEdit_Cubit/profile_edit_state.dart';
import '../../themes/firefly_theme.dart';

class DeleteConfirmationView extends StatelessWidget {
  final bool isGuest;
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onCancel;
  final VoidCallback onDelete;

  const DeleteConfirmationView({
    super.key,
    required this.isGuest,
    required this.formKey,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePasswordVisibility,
    required this.onCancel,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditCubit, ProfileEditState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Final Confirmation',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // For non-guest users, require password confirmation
            if (!isGuest)
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      'Please enter your password to confirm account deletion:',
                      style: TextStyle(
                        color: FireflyTheme.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: onTogglePasswordVisibility,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            else
              Text(
                'Are you sure you want to delete your guest account? This will remove all your data.',
                style: TextStyle(
                  color: FireflyTheme.white,
                  fontSize: 14,
                ),
              ),
              
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: state is ProfileEditLoading ? null : onDelete,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.red,
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
                        : const Text('Delete Account'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}