import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/Character_Bloc/character_bloc.dart';
import '../bloc/Character_Bloc/character_event.dart';
import '../data/character_model.dart';
import '../themes/firefly_theme.dart';


class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback? onTap;

  const CharacterCard({
    super.key,
    required this.character,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: FireflyTheme.cardDecoration,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header con immagine character e cuore
                Row(
                  children: [
                    // Immagine del personaggio
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _getRarityColor(character.rarity),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _getRarityColor(character.rarity).withOpacity(0.3),
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
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: FireflyTheme.jacket,
                              child: Icon(
                                Icons.person,
                                color: FireflyTheme.white,
                                size: 30,
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
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
                          },
                        )
                            : Container(
                          color: FireflyTheme.jacket,
                          child: Icon(
                            Icons.person,
                            color: FireflyTheme.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Nome e stelle rarità
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            character.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: FireflyTheme.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < character.rarity ? Icons.star : Icons.star_border,
                                color: _getRarityColor(character.rarity),
                                size: 16,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    // Pulsante cuore
                    IconButton(
                      onPressed: () {
                        context.read<CharacterBloc>().add(ToggleFavorite(character.id));
                      },
                      icon: Icon(
                        character.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: character.isFavorite ? Colors.red : FireflyTheme.white,
                      ),
                      tooltip: character.isFavorite ? 'Remove from favorites' : 'Add to favorites',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Info Path ed Elemento
                Row(
                  children: [
                    // Immagine Path
                    if (character.pathImage.isNotEmpty) ...[
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: FireflyTheme.turquoise.withOpacity(0.5),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Image.network(
                            character.pathImage,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: FireflyTheme.jacket,
                                child: Icon(
                                  Icons.category,
                                  color: FireflyTheme.turquoise,
                                  size: 12,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                    // Nome Path
                    Expanded(
                      child: Text(
                        character.pathName.isNotEmpty ? character.pathName : 'Unknown Path',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: FireflyTheme.turquoise,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Elemento
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getElementColor(character.element).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _getElementColor(character.element),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        character.element.isNotEmpty ? character.element : 'Unknown',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getElementColor(character.element),
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getRarityColor(int rarity) {
    switch (rarity) {
      case 5:
        return const Color(0xFFFFD700); // Gold
      case 4:
        return const Color(0xFFB19CD9); // Purple
      case 3:
        return const Color(0xFF4FC3F7); // Blue
      default:
        return FireflyTheme.white;
    }
  }

  Color _getElementColor(String element) {
    switch (element.toLowerCase()) {
      case 'fire':
        return const Color(0xFFFF6B6B);
      case 'ice':
        return const Color(0xFF74C0FC);
      case 'lightning':
        return const Color(0xFFFFD93D);
      case 'wind':
        return const Color(0xFF51CF66);
      case 'physical':
        return const Color(0xFFCED4DA);
      case 'quantum':
        return const Color(0xFF9775FA);
      case 'imaginary':
        return const Color(0xFFFFEC99);
      default:
        return FireflyTheme.white;
    }
  }
}