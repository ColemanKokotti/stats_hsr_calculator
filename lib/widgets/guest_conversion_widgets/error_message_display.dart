import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/GuestConversion_Cubit/guest_conversion_cubit.dart';
import '../../bloc/GuestConversion_Cubit/guest_conversion_state.dart';

class ErrorMessageDisplay extends StatelessWidget {
  const ErrorMessageDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuestConversionCubit, GuestConversionState>(
      builder: (context, state) {
        if (state.errorMessage == null) {
          return const SizedBox.shrink();
        }
        
        return Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red),
          ),
          child: Text(
            state.errorMessage!,
            style: const TextStyle(color: Colors.red),
          ),
        );
      },
    );
  }
}