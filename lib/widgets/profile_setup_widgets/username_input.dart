import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/ProfileSetup_Cubit/profile_setup_cubit.dart';
import '../../themes/firefly_theme.dart';

class UsernameInput extends StatelessWidget {
  const UsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => context.read<ProfileSetupCubit>().updateUsername(value),
      style: TextStyle(color: FireflyTheme.white),
      decoration: InputDecoration(
        labelText: 'Username',
        labelStyle: TextStyle(color: FireflyTheme.turquoise),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: FireflyTheme.turquoise),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: FireflyTheme.turquoise, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(Icons.person, color: FireflyTheme.turquoise),
      ),
    );
  }
}