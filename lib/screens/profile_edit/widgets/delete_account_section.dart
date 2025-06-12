import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../bloc/ProfileEdit_Cubit/profile_edit_cubit.dart';
import '../../../bloc/ProfileEdit_Cubit/profile_edit_state.dart';
import '../../../themes/firefly_theme.dart';
import 'section_card.dart';

class DeleteAccountSection extends StatefulWidget {
  const DeleteAccountSection({super.key});

  @override
  State<DeleteAccountSection> createState() => _DeleteAccountSectionState();
}

class _DeleteAccountSectionState extends State<DeleteAccountSection> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isExpanded = false;
  bool _obscurePassword = true;
  bool _showConfirmation = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if user is anonymous (guest)
    final user = FirebaseAuth.instance.currentUser;
    final isGuest = user != null && user.isAnonymous;

    return SectionCard(
      title: 'Delete Account',
      icon: Icons.delete_forever,
      isExpanded: _isExpanded,
      onToggle: () {
        setState(() {
          _isExpanded = !_isExpanded;
          // Reset confirmation when closing
          if (!_isExpanded) {
            _showConfirmation = false;
          }
        });
      },
      expandedContent: BlocConsumer<ProfileEditCubit, ProfileEditState>(
        listener: (context, state) {
          if (state is ProfileEditSuccess && state.message.contains('deleted')) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            // Navigate to auth screen after account deletion
            Navigator.of(context).pushNamedAndRemoveUntil('/auth', (route) => false);
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
          if (_showConfirmation) {
            return _buildConfirmationView(context, state, isGuest);
          } else {
            return _buildWarningView(context);
          }
        },
      ),
    );
  }

  Widget _buildWarningView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Warning: This action cannot be undone',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Deleting your account will permanently remove all your data, including profile information and favorites.',
          style: TextStyle(
            color: FireflyTheme.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _showConfirmation = true;
              });
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              backgroundColor: Colors.red,
            ),
            child: const Text('I understand, proceed to delete'),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmationView(BuildContext context, ProfileEditState state, bool isGuest) {
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
            key: _formKey,
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
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
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
                onPressed: () {
                  setState(() {
                    _showConfirmation = false;
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: state is ProfileEditLoading
                    ? null
                    : () => _deleteAccount(isGuest),
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
  }

  void _deleteAccount(bool isGuest) {
    if (isGuest) {
      // For guest accounts, no password needed
      context.read<ProfileEditCubit>().deleteAccount('');
    } else {
      // For regular accounts, validate password
      if (_formKey.currentState!.validate()) {
        context.read<ProfileEditCubit>().deleteAccount(_passwordController.text);
      }
    }
  }
}