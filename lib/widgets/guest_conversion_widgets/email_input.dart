import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/GuestConversion_Cubit/guest_conversion_cubit.dart';
import '../../themes/firefly_theme.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => context.read<GuestConversionCubit>().updateEmail(value),
      style: TextStyle(color: FireflyTheme.white),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: FireflyTheme.turquoise),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: FireflyTheme.turquoise),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: FireflyTheme.turquoise, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(Icons.email, color: FireflyTheme.turquoise),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}