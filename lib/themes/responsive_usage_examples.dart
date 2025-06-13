import 'package:flutter/material.dart';
import 'responsive_text_utils.dart';
import 'responsive_image_utils.dart';
import 'firefly_theme.dart';

/// Esempi di utilizzo delle utility responsive per testi e immagini
class ResponsiveUsageExamples extends StatelessWidget {
  const ResponsiveUsageExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Examples'),
      ),
      body: SingleChildScrollView(
        padding: ResponsiveTextUtils.getTextContainerPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================== ESEMPI TESTI ====================
            _buildTextExamplesSection(context),
            
            SizedBox(height: ResponsiveTextUtils.getTextVerticalSpacing(context)),
            
            // ==================== ESEMPI IMMAGINI ====================
            _buildImageExamplesSection(context),
          ],
        ),
      ),
    );
  }

  /// Sezione con esempi di testi responsive
  Widget _buildTextExamplesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titolo sezione
        Text(
          'Esempi Testi Responsive',
          style: ResponsiveTextUtils.getDisplayMediumStyle(
            context,
            color: FireflyTheme.gold,
          ),
        ),
        
        SizedBox(height: ResponsiveTextUtils.getTextVerticalSpacing(context)),
        
        // Display Large
        Text(
          'Display Large',
          style: ResponsiveTextUtils.getDisplayLargeStyle(
            context,
            color: FireflyTheme.white,
          ),
        ),
        
        // Headline Medium
        Text(
          'Headline Medium - Sottotitolo',
          style: ResponsiveTextUtils.getHeadlineMediumStyle(
            context,
            color: FireflyTheme.turquoise,
          ),
        ),
        
        // Title Large
        Text(
          'Title Large - Titolo Sezione',
          style: ResponsiveTextUtils.getTitleLargeStyle(
            context,
            color: FireflyTheme.gold,
          ),
        ),
        
        // Body Large
        Text(
          'Body Large - Questo è un esempio di testo del corpo che si adatta automaticamente alle dimensioni dello schermo. Su mobile sarà più piccolo, su tablet medio e su desktop più grande.',
          style: ResponsiveTextUtils.getBodyLargeStyle(
            context,
            color: FireflyTheme.white,
          ),
        ),
        
        SizedBox(height: ResponsiveTextUtils.getTextVerticalSpacing(context)),
        
        // Body Medium
        Text(
          'Body Medium - Testo di dimensioni medie per contenuti secondari.',
          style: ResponsiveTextUtils.getBodyMediumStyle(
            context,
            color: FireflyTheme.white,
          ),
        ),
        
        // Label Small
        Text(
          'Label Small - Etichetta piccola',
          style: ResponsiveTextUtils.getLabelSmallStyle(
            context,
            color: FireflyTheme.turquoise,
          ),
        ),
      ],
    );
  }

  /// Sezione con esempi di immagini responsive
  Widget _buildImageExamplesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titolo sezione
        Text(
          'Esempi Immagini Responsive',
          style: ResponsiveTextUtils.getDisplayMediumStyle(
            context,
            color: FireflyTheme.gold,
          ),
        ),
        
        SizedBox(height: ResponsiveTextUtils.getTextVerticalSpacing(context)),
        
        // Avatar Grande
        Row(
          children: [
            ResponsiveImageUtils.buildResponsiveCircleAvatar(
              context,
              backgroundImage: const AssetImage('assets/profile_images/default_avatar.png'),
              size: ResponsiveImageUtils.getLargeAvatarSize(context),
              backgroundColor: FireflyTheme.turquoise,
            ),
            SizedBox(width: ResponsiveImageUtils.getImageGridSpacing(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Avatar Responsive',
                    style: ResponsiveTextUtils.getTitleLargeStyle(context, color: FireflyTheme.gold),
                  ),
                  Text(
                    'L\'avatar si adatta alle dimensioni dello schermo',
                    style: ResponsiveTextUtils.getBodyMediumStyle(context, color: FireflyTheme.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        SizedBox(height: ResponsiveImageUtils.getImageGridSpacing(context)),
        
        // Immagine con AspectRatio
        Text(
          'Immagine 16:9 Responsive',
          style: ResponsiveTextUtils.getTitleMediumStyle(context, color: FireflyTheme.turquoise),
        ),
        SizedBox(height: ResponsiveTextUtils.getTextVerticalSpacing(context, mobileSpacing: 4, tabletSpacing: 6, desktopSpacing: 8)),
        
        ResponsiveImageUtils.buildResponsiveAspectRatioImage(
          context,
          image: const AssetImage('assets/images/firefly.png'),
          aspectRatio: ResponsiveImageUtils.landscapeAspectRatio,
          borderRadius: ResponsiveImageUtils.getMediumImageBorderRadius(context),
        ),
        
        SizedBox(height: ResponsiveImageUtils.getImageGridSpacing(context)),
        
        // Griglia di icone
        Text(
          'Griglia Icone Responsive',
          style: ResponsiveTextUtils.getTitleMediumStyle(context, color: FireflyTheme.turquoise),
        ),
        SizedBox(height: ResponsiveTextUtils.getTextVerticalSpacing(context, mobileSpacing: 4, tabletSpacing: 6, desktopSpacing: 8)),
        
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveImageUtils.getGridViewCrossAxisCount(context),
            crossAxisSpacing: ResponsiveImageUtils.getImageGridSpacing(context),
            mainAxisSpacing: ResponsiveImageUtils.getImageGridSpacing(context),
            childAspectRatio: ResponsiveImageUtils.squareAspectRatio,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: FireflyTheme.turquoise.withOpacity(0.3),
                borderRadius: BorderRadius.circular(
                  ResponsiveImageUtils.getSmallImageBorderRadius(context),
                ),
                border: Border.all(
                  color: FireflyTheme.gold.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.star,
                size: ResponsiveImageUtils.getMediumIconSize(context),
                color: FireflyTheme.gold,
              ),
            );
          },
        ),
        
        SizedBox(height: ResponsiveImageUtils.getImageGridSpacing(context)),
        
        // Esempio card con immagine
        Text(
          'Card con Immagine Responsive',
          style: ResponsiveTextUtils.getTitleMediumStyle(context, color: FireflyTheme.turquoise),
        ),
        SizedBox(height: ResponsiveTextUtils.getTextVerticalSpacing(context, mobileSpacing: 4, tabletSpacing: 6, desktopSpacing: 8)),
        
        Container(
          width: ResponsiveImageUtils.getCardImageWidth(context),
          decoration: FireflyTheme.cardDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Immagine della card
              ResponsiveImageUtils.buildResponsiveClippedImage(
                context,
                image: const AssetImage('assets/images/firefly.png'),
                width: ResponsiveImageUtils.getCardImageWidth(context),
                height: ResponsiveImageUtils.getCardImageHeight(context),
                borderRadius: ResponsiveImageUtils.getMediumImageBorderRadius(context),
              ),
              
              // Contenuto della card
              Padding(
                padding: ResponsiveImageUtils.getImageContainerPadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Titolo Card',
                      style: ResponsiveTextUtils.getTitleLargeStyle(context, color: FireflyTheme.gold),
                    ),
                    SizedBox(height: ResponsiveTextUtils.getTextVerticalSpacing(context, mobileSpacing: 2, tabletSpacing: 4, desktopSpacing: 6)),
                    Text(
                      'Descrizione che si adatta alle dimensioni del dispositivo.',
                      style: ResponsiveTextUtils.getBodyMediumStyle(context, color: FireflyTheme.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Widget esempio più semplice per mostrare l'uso base
class SimpleResponsiveExample extends StatelessWidget {
  const SimpleResponsiveExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Testo responsive
        Text(
          'Titolo Responsive',
          style: ResponsiveTextUtils.getHeadlineLargeStyle(
            context,
            color: FireflyTheme.gold,
          ),
        ),
        
        // Spaziatura responsive
        SizedBox(height: ResponsiveTextUtils.getTextVerticalSpacing(context)),
        
        // Avatar responsive
        ResponsiveImageUtils.buildResponsiveCircleAvatar(
          context,
          backgroundImage: const AssetImage('assets/profile_images/default_avatar.png'),
          size: ResponsiveImageUtils.getMediumAvatarSize(context),
        ),
      ],
    );
  }
}