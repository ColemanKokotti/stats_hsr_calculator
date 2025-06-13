import 'package:flutter/material.dart';
import '../../../data/character_model.dart';
import '../../../data/character_rarity.dart';
import '../../../themes/firefly_theme.dart';

class MyCharacterImage extends StatelessWidget {
  final Character character;
  final double size;
  final bool isCircular;

  const MyCharacterImage({
    super.key,
    required this.character,
    this.size = 60,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircular ? null : BorderRadius.circular(8),
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
      child: isCircular
          ? ClipOval(
              child: _buildImage(),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: _buildImage(),
            ),
    );
  }

  Widget _buildImage() {
    return character.imageUrl.isNotEmpty
        ? Image.network(
            character.imageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return _buildLoadingIndicator(loadingProgress);
            },
          )
        : _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: FireflyTheme.jacket,
      child: Icon(
        Icons.person,
        color: FireflyTheme.white,
        size: size / 2,
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