import 'package:flutter/material.dart';
import '../../data/character_model.dart';
import '../../themes/firefly_theme.dart';
import '../../themes/responsive_utils.dart';
import 'character_features_icons_row.dart';

class CharacterPortraitSection extends StatelessWidget {
  final Character character;

  const CharacterPortraitSection({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    // Calcoliamo le dimensioni del portrait in base allo schermo
    final portraitWidth = ResponsiveImageUtils.getResponsiveSize(
      context,
      mobileSize: 180,
      tabletSize: 240,
      desktopSize: 300,
    );
    final portraitHeight = ResponsiveImageUtils.getResponsiveSize(
      context,
      mobileSize: 270,
      tabletSize: 360,
      desktopSize: 450,
    );
    
    return Column(
      children: [
        // Portrait Image
        Container(
          width: portraitWidth,
          height: portraitHeight,
          decoration: BoxDecoration(
            borderRadius: ResponsiveUtils.getResponsiveBorderRadius(
              context,
              mobileRadius: 10,
              tabletRadius: 12,
              desktopRadius: 16,
            ),
            gradient: FireflyTheme.cardGradient,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: ResponsiveUtils.getResponsiveValue(
                  context,
                  mobileValue: 12,
                  tabletValue: 15,
                  desktopValue: 20,
                ),
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: ResponsiveUtils.getResponsiveBorderRadius(
              context,
              mobileRadius: 10,
              tabletRadius: 12,
              desktopRadius: 16,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        FireflyTheme.jacket.withOpacity(0.1),
                        FireflyTheme.jacket.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
                
                // Character ingame portrait
                character.ingamePortrait.isNotEmpty
                    ? Image.network(
                        character.ingamePortrait,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: FireflyTheme.jacket.withOpacity(0.5),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: FireflyTheme.turquoise,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image: ${character.ingamePortrait}');
                          print('Error details: $error');
                          return Container(
                            color: FireflyTheme.jacket.withOpacity(0.5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 64,
                                  color: FireflyTheme.white.withOpacity(0.5),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Image not found',
                                  style: TextStyle(
                                    color: FireflyTheme.white.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Container(
                        color: FireflyTheme.jacket.withOpacity(0.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              size: 64,
                              color: FireflyTheme.white.withOpacity(0.5),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'No image available',
                              style: TextStyle(
                                color: FireflyTheme.white.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

              ],
            ),
          ),
        ),

      ],
    );
  }
}