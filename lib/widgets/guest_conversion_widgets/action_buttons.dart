import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/GuestConversion_Cubit/guest_conversion_cubit.dart';
import '../../bloc/GuestConversion_Cubit/guest_conversion_state.dart';
import '../../themes/firefly_theme.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuestConversionCubit, GuestConversionState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Submit button
            ElevatedButton(
              onPressed: state.isSubmitting 
                ? null 
                : () => context.read<GuestConversionCubit>().convertGuestAccount(),
              style: ElevatedButton.styleFrom(
                backgroundColor: FireflyTheme.turquoise,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                disabledBackgroundColor: FireflyTheme.turquoise.withOpacity(0.5),
              ),
              child: state.isSubmitting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Convert Account',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
            const SizedBox(height: 16),
            
            // Cancel button
            TextButton(
              onPressed: state.isSubmitting 
                  ? null 
                  : () => Navigator.of(context).pop(false), // Return false to indicate cancellation
              style: TextButton.styleFrom(
                foregroundColor: FireflyTheme.white,
              ),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}