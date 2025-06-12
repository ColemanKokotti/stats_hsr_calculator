import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';
import '../../screens/my_characters/my_characters_screen.dart';

class MyCharactersButton extends StatelessWidget {
  const MyCharactersButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: FireflyTheme.turquoiseGradient,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateToMyCharacters(context),
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(
                'assets/images/character-icon.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToMyCharacters(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyCharactersScreen(),
      ),
    );
  }
}