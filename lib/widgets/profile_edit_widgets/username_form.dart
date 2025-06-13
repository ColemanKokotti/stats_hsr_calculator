import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/ProfileEdit_Cubit/profile_edit_cubit.dart';
import '../../bloc/ProfileEdit_Cubit/profile_edit_state.dart';
import '../../themes/firefly_theme.dart';

class UsernameForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final VoidCallback onUpdateUsername;

  const UsernameForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.onUpdateUsername,
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
              TextFormField(
                controller: usernameController,
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
                  onPressed: state is ProfileEditLoading ? null : onUpdateUsername,
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
    );
  }
}