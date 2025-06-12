import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../bloc/Auth_Cubit/auth_cubit.dart';
import '../bloc/GuestConversion_Cubit/guest_conversion_cubit.dart';
import '../bloc/GuestConversion_Cubit/guest_conversion_state.dart';
import '../themes/firefly_theme.dart';
import '../widgets/guest_conversion_widgets/guest_conversion_form.dart';

class GuestConversionScreen extends StatelessWidget {
  const GuestConversionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GuestConversionCubit(
        auth: FirebaseAuth.instance,
        authCubit: context.read<AuthCubit>(),
      ),
      child: BlocListener<GuestConversionCubit, GuestConversionState>(
        listenWhen: (previous, current) => 
          !previous.isSuccess && current.isSuccess,
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account successfully converted!')),
            );
            Navigator.of(context).pop(true); // Return true to indicate success
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Convert Guest Account'),
            backgroundColor: FireflyTheme.jacket,
          ),
          body: Container(
            decoration: BoxDecoration(gradient: FireflyTheme.backgroundGradient),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: GuestConversionForm(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}