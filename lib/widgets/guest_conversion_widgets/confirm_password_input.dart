import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/GuestConversion_Cubit/guest_conversion_cubit.dart';
import '../../themes/firefly_theme.dart';

class ConfirmPasswordInput extends StatelessWidget {
  const ConfirmPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => context.read<GuestConversionCubit>().updateConfirmPassword(value),
      style: TextStyle(color: FireflyTheme.white),
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        labelStyle: TextStyle(color: FireflyTheme.turquoise),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: FireflyTheme.turquoise),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: FireflyTheme.turquoise, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(Icons.lock_outline, color: FireflyTheme.turquoise),
      ),
      obscureText: true,
    );
  }
}