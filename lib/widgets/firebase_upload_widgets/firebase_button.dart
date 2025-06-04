import 'package:flutter/material.dart';

class FirebaseButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const FirebaseButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FirebaseUploadScreen(),
          ),
        );
      },
      icon: const Icon(Icons.cloud_upload),
      tooltip: 'Upload to Firebase',
    );
  }
}

// Schermata placeholder - sostituisci con la tua implementazione
class FirebaseUploadScreen extends StatelessWidget {
  const FirebaseUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Upload'),
      ),
      body: const Center(
        child: Text('Firebase Upload Screen'),
      ),
    );
  }
}