import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/ProfileEdit_Cubit/profile_edit_cubit.dart';
import '../../../bloc/ProfileEdit_Cubit/profile_edit_state.dart';
import '../../../bloc/Profile_Cubit/profile_cubit.dart';
import '../../../bloc/Profile_Cubit/profile_state.dart';
import '../../../themes/firefly_theme.dart';
import 'section_card.dart';

class EditUserNameSection extends StatefulWidget {
  const EditUserNameSection({super.key});

  @override
  State<EditUserNameSection> createState() => _EditUserNameSectionState();
}

class _EditUserNameSectionState extends State<EditUserNameSection> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  bool _isExpanded = false;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        // Pre-fill with current username if available
        if (profileState is ProfileLoaded && 
            profileState.profile.username != null && 
            _usernameController.text.isEmpty) {
          _usernameController.text = profileState.profile.username!;
        }

        return SectionCard(
          title: 'Username',
          icon: Icons.person,
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
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'New Username',
                        hintText: 'Enter your new username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        if (value.length < 3) {
                          return 'Username must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is ProfileEditLoading
                            ? null
                            : _updateUsername,
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
                            : const Text('Update Username'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _updateUsername() {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileEditCubit>().updateUsername(_usernameController.text);
    }
  }
}