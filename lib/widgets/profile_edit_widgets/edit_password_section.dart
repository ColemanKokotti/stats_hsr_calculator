import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_project/widgets/profile_edit_widgets/section_card.dart';
import '../../bloc/ProfileEdit_Cubit/profile_edit_cubit.dart';
import '../../bloc/ProfileEdit_Cubit/profile_edit_state.dart';
import '../../bloc/password_form_cubit.dart';
import 'password_form.dart';

class EditPasswordSection extends StatelessWidget {
  const EditPasswordSection({super.key});

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
        expandedContent: Container(),
        subtitle: 'Not available for guest accounts',
      );
    }

    return BlocProvider(
      create: (context) => PasswordFormCubit(),
      child: const _EditPasswordContent(),
    );
  }
}

class _EditPasswordContent extends StatelessWidget {
  const _EditPasswordContent();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return BlocBuilder<PasswordFormCubit, PasswordFormState>(
      builder: (context, formState) {
        return SectionCard(
          title: 'Password',
          icon: Icons.lock,
          isExpanded: formState.isExpanded,
          onToggle: () {
            context.read<PasswordFormCubit>().toggleExpansion();
          },
          expandedContent: BlocConsumer<ProfileEditCubit, ProfileEditState>(
            listener: (context, state) {
              if (state is ProfileEditSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                context.read<ProfileEditCubit>().resetState();
                currentPasswordController.clear();
                newPasswordController.clear();
                confirmPasswordController.clear();
                context.read<PasswordFormCubit>().closeSection();
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
              return PasswordForm(
                formKey: formKey,
                currentPasswordController: currentPasswordController,
                newPasswordController: newPasswordController,
                confirmPasswordController: confirmPasswordController,
                obscureCurrentPassword: formState.obscureCurrentPassword,
                obscureNewPassword: formState.obscureNewPassword,
                obscureConfirmPassword: formState.obscureConfirmPassword,
                onToggleCurrentPassword: () {
                  context.read<PasswordFormCubit>().toggleCurrentPasswordVisibility();
                },
                onToggleNewPassword: () {
                  context.read<PasswordFormCubit>().toggleNewPasswordVisibility();
                },
                onToggleConfirmPassword: () {
                  context.read<PasswordFormCubit>().toggleConfirmPasswordVisibility();
                },
                onUpdatePassword: () {
                  if (formKey.currentState!.validate()) {
                    context.read<ProfileEditCubit>().updatePassword(
                      currentPasswordController.text,
                      newPasswordController.text,
                    );
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}