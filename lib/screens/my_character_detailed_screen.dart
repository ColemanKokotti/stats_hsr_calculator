import 'package:flutter/material.dart';
import '../data/character_model.dart';
import '../themes/firefly_theme.dart';

class MyCharacterDetailedScreen extends StatelessWidget {
  final Character character;

  const MyCharacterDetailedScreen({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FireflyTheme.jacket,
      appBar: AppBar(
        backgroundColor: FireflyTheme.turquoiseDark,
        title: Text(
          character.name,
          style: TextStyle(
            color: FireflyTheme.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: FireflyTheme.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FireflyTheme.gradientText(
              'Character Details',
              gradient: FireflyTheme.eyesGradient,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome to ${character.name} detailed view!',
              style: TextStyle(
                color: FireflyTheme.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}