import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/character_model.dart';
import '../../themes/firefly_theme.dart';
import '../../bloc/MyCharacters_Cubit/my_characters_cubit.dart';
import '../../bloc/MyCharacters_Cubit/my_characters_state.dart';
import 'my_character_image.dart';

class CharacterSelectionGrid extends StatelessWidget {
  final List<Character> characters;
  final Set<String> selectedCharacterIds;
  final Function(String) onToggleSelection;

  const CharacterSelectionGrid({
    super.key,
    required this.characters,
    required this.selectedCharacterIds,
    required this.onToggleSelection,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCharactersCubit, MyCharactersState>(
      builder: (context, state) {
        if (state is MyCharactersLoaded) {
          return Column(
            children: [
              Flexible(
                child: _buildMangaStylePage(context, state),
              ),
              const SizedBox(height: 8),
              _buildPageNavigation(context, state),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildMangaStylePage(BuildContext context, MyCharactersLoaded state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: FireflyTheme.jacket.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: FireflyTheme.turquoise.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Page background with manga-style texture
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: Container(
                  color: FireflyTheme.jacket.withOpacity(0.05),
                  child: CustomPaint(
                    painter: MangaTexturePainter(),
                    size: Size.infinite,
                  ),
                ),
              ),
            ),
            
            // Characters grid
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 36.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.0,
                ),
                itemCount: state.currentPageCharacters.length,
                itemBuilder: (context, index) {
                  final character = state.currentPageCharacters[index];
                  final isSelected = selectedCharacterIds.contains(character.id);
                  
                  return _buildCharacterCard(context, character, isSelected);
                },
              ),
            ),

            // Page number indicator
            Positioned(
              bottom: 8,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: FireflyTheme.jacket.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: FireflyTheme.turquoise.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Text(
                  'Page ${state.currentPage + 1} of ${state.totalPages}',
                  style: TextStyle(
                    color: FireflyTheme.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageNavigation(BuildContext context, MyCharactersLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous page button
          _buildNavigationButton(
            context: context,
            icon: Icons.arrow_back_ios_rounded,
            onPressed: state.currentPage > 0
                ? () => context.read<MyCharactersCubit>().previousPage()
                : null,
          ),
          
          // Page indicators
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                state.totalPages,
                (index) => _buildPageIndicator(
                  context: context,
                  isActive: index == state.currentPage,
                  pageNumber: index + 1,
                  onTap: () => context.read<MyCharactersCubit>().goToPage(index),
                ),
              ),
            ),
          ),
          
          // Next page button
          _buildNavigationButton(
            context: context,
            icon: Icons.arrow_forward_ios_rounded,
            onPressed: state.currentPage < state.totalPages - 1
                ? () => context.read<MyCharactersCubit>().nextPage()
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton({
    required BuildContext context,
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: onPressed != null ? FireflyTheme.turquoiseGradient : null,
        color: onPressed == null ? FireflyTheme.jacket.withOpacity(0.5) : null,
        shape: BoxShape.circle,
        boxShadow: onPressed != null
            ? [
                BoxShadow(
                  color: FireflyTheme.turquoise.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: onPressed != null ? FireflyTheme.jacket : FireflyTheme.white.withOpacity(0.3),
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator({
    required BuildContext context,
    required bool isActive,
    required int pageNumber,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: isActive ? 30 : 10,
        height: 10,
        decoration: BoxDecoration(
          color: isActive ? FireflyTheme.turquoise : FireflyTheme.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: FireflyTheme.turquoise.withOpacity(0.5),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: isActive
            ? Center(
                child: Text(
                  '$pageNumber',
                  style: TextStyle(
                    color: FireflyTheme.jacket,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
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

class MangaTexturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42); // Fixed seed for consistent pattern
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.05)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Draw horizontal tone lines (manga style)
    for (double y = 0; y < size.height; y += 4) {
      final path = Path();
      path.moveTo(0, y);
      path.lineTo(size.width, y);
      canvas.drawPath(path, paint);
    }

    // Draw some random dots for texture
    final dotPaint = Paint()
      ..color = Colors.black.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 500; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 1.5;
      canvas.drawCircle(Offset(x, y), radius, dotPaint);
    }

    // Draw some manga-style speed lines
    final speedLinePaint = Paint()
      ..color = Colors.black.withOpacity(0.04)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 20; i++) {
      final startX = random.nextDouble() * size.width;
      final startY = random.nextDouble() * size.height;
      final length = 50 + random.nextDouble() * 100;
      final angle = random.nextDouble() * 2 * pi;
      
      final endX = startX + length * cos(angle);
      final endY = startY + length * sin(angle);
      
      final path = Path();
      path.moveTo(startX, startY);
      path.lineTo(endX, endY);
      canvas.drawPath(path, speedLinePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}