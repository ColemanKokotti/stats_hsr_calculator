import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';

class DeleteWarningView extends StatelessWidget {
  final VoidCallback onProceed;

  const DeleteWarningView({
    super.key,
    required this.onProceed,
  });

  @override
  Widget build(BuildContext context) {
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
            onPressed: onProceed,
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
}