import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../bloc/ProfileEdit_Cubit/profile_edit_cubit.dart';
import '../../../bloc/ProfileEdit_Cubit/profile_edit_state.dart';
import '../../../themes/firefly_theme.dart';
import 'section_card.dart';

class EditPasswordSection extends StatefulWidget {
  const EditPasswordSection({super.key});

  @override
  State<EditPasswordSection> createState() => _EditPasswordSectionState();
}

class _EditPasswordSectionState extends State<EditPasswordSection> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isExpanded = false;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if user is anonymous (guest)
    final user = FirebaseAuth.instance.currentUser;
    final isGuest = user != null && user.isAnonymous;

    if (isGuest) {
      return SectionCard(
        title: 'Password',
        icon: Icons.lock,
        isExpanded: false,
        onToggle: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Guest accounts cannot change password'),
              backgroundColor: Colors.orange,
            ),
          );
        },
        expandedContent: Container(), // Empty container as it won't expand
        subtitle: 'Not available for guest accounts',
      );
    }

    return SectionCard(
      title: 'Password',
      icon: Icons.lock,
      isExpanded: _isExpanded,
      onToggle: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      expandedContent: BlocConsumer<ProfileEditCubit, ProfileEditState>(
        listener: (context, state) {
          if (state is ProfileEditSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            // Reset state after showing success message
            context.read<ProfileEditCubit>().resetState();
            // Clear form fields
            _currentPasswordController.clear();
            _newPasswordController.clear();
            _confirmPasswordController.clear();
            // Close the expanded section
            setState(() {
              _isExpanded = false;
            });
          } else if (state is ProfileEditError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _currentPasswordController,
                  obscureText: _obscureCurrentPassword,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    hintText: 'Enter your current password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureCurrentPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureCurrentPassword = !_obscureCurrentPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: _obscureNewPassword,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    hintText: 'Enter your new password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNewPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureNewPassword = !_obscureNewPassword;
                        });
                      },
                    ),
                  ),
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
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    hintText: 'Confirm your new password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your new password';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state is ProfileEditLoading
                        ? null
                        : _updatePassword,
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
      ),
    );
  }

  void _updatePassword() {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileEditCubit>().updatePassword(
        _currentPasswordController.text,
        _newPasswordController.text,
      );
    }
  }
}