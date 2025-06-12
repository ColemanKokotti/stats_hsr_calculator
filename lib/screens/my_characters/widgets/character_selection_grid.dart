import 'package:flutter/material.dart';
import '../../../data/character_model.dart';
import '../../../themes/firefly_theme.dart';
import 'my_character_image.dart';

class CharacterSelectionGrid extends StatelessWidget {
  final List<Character> characters;
  final List<String> selectedCharacterIds;
  final Function(String) onToggleSelection;

  const CharacterSelectionGrid({
    super.key,
    required this.characters,
    required this.selectedCharacterIds,
    required this.onToggleSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75, // Adjust for character name below image
        ),
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final character = characters[index];
          final isSelected = selectedCharacterIds.contains(character.id);
          
          return _buildCharacterCard(context, character, isSelected);
        },
      ),
    );
  }

  Widget _buildCharacterCard(BuildContext context, Character character, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        gradient: FireflyTheme.cardGradient,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? FireflyTheme.gold : FireflyTheme.jacket.withOpacity(0.2),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onToggleSelection(character.id),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Selection indicator
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? FireflyTheme.gold : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? FireflyTheme.gold : FireflyTheme.white.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        isSelected ? Icons.check : null,
                        color: FireflyTheme.jacket,
                        size: 16,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Character image
                Expanded(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: FireflyTheme.gold.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                      child: MyCharacterImage(
                        character: character,
                        size: 80,
                        isCircular: true,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Character name
                Text(
                  character.name,
                  style: TextStyle(
                    color: FireflyTheme.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}