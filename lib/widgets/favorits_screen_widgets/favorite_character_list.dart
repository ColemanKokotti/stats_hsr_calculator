import 'package:flutter/material.dart';
import '../../data/character_model.dart';
import '../../screens/character_detailed_screen.dart';
import '../../themes/firefly_theme.dart';
import '../home_screen_widgets/character_card_widget.dart';

class FavoriteCharactersList extends StatelessWidget {
  final List<Character> favoriteCharacters;

  const FavoriteCharactersList({
    super.key,
    required this.favoriteCharacters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Counter
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(
                '${favoriteCharacters.length} favorite${favoriteCharacters.length != 1 ? 's' : ''}',
                style: TextStyle(
                  color: FireflyTheme.white.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: favoriteCharacters.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CharacterCard(
                  character: favoriteCharacters[index],
                  onTap: () {
                    // Naviga al detail screen con MaterialPageRoute
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailScreen(
                          character: favoriteCharacters[index],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}