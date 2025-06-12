import 'package:flutter/material.dart';

class CharacterLoadingWidget extends StatelessWidget {
  const CharacterLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}