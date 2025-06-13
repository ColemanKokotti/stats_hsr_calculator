import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_project/widgets/profile_edit_widgets/section_card.dart';
import '../../bloc/ProfileEdit_Cubit/profile_edit_cubit.dart';
import '../../bloc/ProfileEdit_Cubit/profile_edit_state.dart';
import '../../bloc/Profile_Cubit/profile_cubit.dart';
import '../../bloc/Profile_Cubit/profile_state.dart';
import '../../bloc/username_form_cubit.dart';
import 'username_form.dart';

class EditUserNameSection extends StatelessWidget {
  const EditUserNameSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsernameFormCubit(),
      child: const _EditUsernameContent(),
    );
  }
}

class _EditUsernameContent extends StatelessWidget {
  const _EditUsernameContent();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final usernameController = TextEditingController();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        // Pre-fill with current username if available
        if (profileState is ProfileLoaded && 
            profileState.profile.username != null && 
            usernameController.text.isEmpty) {
          usernameController.text = profileState.profile.username!;
        }

        return BlocBuilder<UsernameFormCubit, UsernameFormState>(
          builder: (context, formState) {
            return SectionCard(
              title: 'Username',
              icon: Icons.person,
              isExpanded: formState.isExpanded,
              onToggle: () {
                context.read<UsernameFormCubit>().toggleExpansion();
              },
              expandedContent: BlocConsumer<ProfileEditCubit, ProfileEditState>(
                listener: (context, state) {
                  if (state is ProfileEditSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                    context.read<ProfileEditCubit>().resetState();
                    context.read<UsernameFormCubit>().closeSection();
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
                  return UsernameForm(
                    formKey: formKey,
                    usernameController: usernameController,
                    onUpdateUsername: () {
                      if (formKey.currentState!.validate()) {
                        context.read<ProfileEditCubit>().updateUsername(usernameController.text);
                      }
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}