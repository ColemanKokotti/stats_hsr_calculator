import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_project/widgets/profile_edit_widgets/section_card.dart';
import '../../bloc/ProfileEdit_Cubit/profile_edit_cubit.dart';
import '../../bloc/ProfileEdit_Cubit/profile_edit_state.dart';
import '../../bloc/delete_account_cubit.dart';
import 'delete_warning_view.dart';
import 'delete_confirmation_view.dart';

class DeleteAccountSection extends StatelessWidget {
  const DeleteAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteAccountCubit(),
      child: const _DeleteAccountContent(),
    );
  }
}

class _DeleteAccountContent extends StatelessWidget {
  const _DeleteAccountContent();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final passwordController = TextEditingController();

    return BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
      builder: (context, deleteState) {
        // Check if user is anonymous (guest)
        final user = FirebaseAuth.instance.currentUser;
        final isGuest = user != null && user.isAnonymous;

        return SectionCard(
          title: 'Delete Account',
          icon: Icons.delete_forever,
          isExpanded: deleteState.isExpanded,
          onToggle: () {
            context.read<DeleteAccountCubit>().toggleExpansion();
          },
          expandedContent: BlocConsumer<ProfileEditCubit, ProfileEditState>(
            listener: (context, state) {
              if (state is ProfileEditSuccess && state.message.contains('deleted')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
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
              if (deleteState.showConfirmation) {
                return DeleteConfirmationView(
                  isGuest: isGuest,
                  formKey: formKey,
                  passwordController: passwordController,
                  obscurePassword: deleteState.obscurePassword,
                  onTogglePasswordVisibility: () {
                    context.read<DeleteAccountCubit>().togglePasswordVisibility();
                  },
                  onCancel: () {
                    context.read<DeleteAccountCubit>().hideConfirmation();
                  },
                  onDelete: () {
                    if (isGuest) {
                      context.read<ProfileEditCubit>().deleteAccount('');
                    } else {
                      if (formKey.currentState!.validate()) {
                        context.read<ProfileEditCubit>().deleteAccount(passwordController.text);
                      }
                    }
                  },
                );
              } else {
                return DeleteWarningView(
                  onProceed: () {
                    context.read<DeleteAccountCubit>().showConfirmation();
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}