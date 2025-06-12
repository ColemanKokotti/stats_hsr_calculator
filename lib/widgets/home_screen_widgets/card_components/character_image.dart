import 'package:flutter/material.dart';
import '../../../data/character_model.dart';
import '../../../data/character_rarity.dart';
import '../../../themes/firefly_theme.dart';

class CharacterImage extends StatelessWidget {
  final Character character;

  const CharacterImage({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: CharacterUtils.getRarityColor(character.rarity),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: CharacterUtils.getRarityColor(character.rarity),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: character.imageUrl.isNotEmpty
            ? Image.network(
          character.imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _buildLoadingIndicator(loadingProgress);
          },
        )
            : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: FireflyTheme.jacket,
      child: Icon(
        Icons.person,
        color: FireflyTheme.white,
        size: 30,
      ),
    );
  }

  Widget _buildLoadingIndicator(ImageChunkEvent loadingProgress) {
    return Container(
      color: FireflyTheme.jacket,
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
              : null,
          color: FireflyTheme.turquoise,
          strokeWidth: 2,
        ),
      ),
    );
  }
}