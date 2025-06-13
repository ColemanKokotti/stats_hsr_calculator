import 'package:flutter/material.dart';

/// Utility class per gestire le dimensioni delle immagini in modo responsive
class ResponsiveImageUtils {
  // Breakpoints standard
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 900;
  static const double _desktopBreakpoint = 1200;

  /// Verifica se lo schermo è mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < _mobileBreakpoint;
  }

  /// Verifica se lo schermo è tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= _mobileBreakpoint && width < _tabletBreakpoint;
  }

  /// Verifica se lo schermo è desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= _tabletBreakpoint;
  }

  /// Ottiene una dimensione responsive generica
  static double getResponsiveSize(
    BuildContext context, {
    required double mobileSize,
    required double tabletSize,
    required double desktopSize,
  }) {
    if (isMobile(context)) return mobileSize;
    if (isTablet(context)) return tabletSize;
    return desktopSize;
  }

  // ==================== IMAGE SIZES ====================

  /// Avatar piccolo - per profili in liste, icone utente
  static double getSmallAvatarSize(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 32,
      tabletSize: 36,
      desktopSize: 40,
    );
  }

  /// Avatar medio - per profili standard
  static double getMediumAvatarSize(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 48,
      tabletSize: 56,
      desktopSize: 64,
    );
  }

  /// Avatar grande - per profili dettagliati
  static double getLargeAvatarSize(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 80,
      tabletSize: 100,
      desktopSize: 120,
    );
  }

  /// Avatar extra large - per profili principali
  static double getExtraLargeAvatarSize(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 120,
      tabletSize: 150,
      desktopSize: 180,
    );
  }

  /// Icona piccola - per pulsanti, indicatori
  static double getSmallIconSize(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 16,
      tabletSize: 18,
      desktopSize: 20,
    );
  }

  /// Icona media - per interfaccia standard
  static double getMediumIconSize(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 24,
      tabletSize: 28,
      desktopSize: 32,
    );
  }

  /// Icona grande - per elementi prominenti
  static double getLargeIconSize(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 32,
      tabletSize: 40,
      desktopSize: 48,
    );
  }

  /// Icona extra large - per elementi principali
  static double getExtraLargeIconSize(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 48,
      tabletSize: 64,
      desktopSize: 80,
    );
  }

  /// Thumbnail piccolo - per anteprime in liste
  static double getSmallThumbnailSize(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 60,
      tabletSize: 80,
      desktopSize: 100,
    );
  }

  /// Thumbnail medio - per gallerie
  static double getMediumThumbnailSize(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 100,
      tabletSize: 120,
      desktopSize: 150,
    );
  }

  /// Thumbnail grande - per preview importanti
  static double getLargeThumbnailSize(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 150,
      tabletSize: 200,
      desktopSize: 250,
    );
  }

  /// Card image - per immagini nelle card
  static double getCardImageHeight(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 120,
      tabletSize: 150,
      desktopSize: 180,
    );
  }

  /// Hero image - per immagini principali
  static double getHeroImageHeight(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 200,
      tabletSize: 280,
      desktopSize: 350,
    );
  }

  /// Banner image - per banner orizzontali
  static double getBannerImageHeight(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 100,
      tabletSize: 140,
      desktopSize: 180,
    );
  }

  // ==================== IMAGE WIDTHS ====================

  /// Larghezza per immagini a schermo intero
  static double getFullWidthImageWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Larghezza per immagini in card
  static double getCardImageWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return getResponsiveSize(
      context,
      mobileSize: screenWidth * 0.9,
      tabletSize: screenWidth * 0.8,
      desktopSize: screenWidth * 0.6,
    );
  }

  /// Larghezza per gallery items
  static double getGalleryItemWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return getResponsiveSize(
      context,
      mobileSize: screenWidth * 0.45,
      tabletSize: screenWidth * 0.3,
      desktopSize: screenWidth * 0.25,
    );
  }

  /// Larghezza per immagini di dettaglio
  static double getDetailImageWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return getResponsiveSize(
      context,
      mobileSize: screenWidth * 0.8,
      tabletSize: screenWidth * 0.6,
      desktopSize: screenWidth * 0.4,
    );
  }

  // ==================== BORDER RADIUS ====================

  /// Border radius per avatari circolari
  static double getCircularImageRadius(double size) {
    return size / 2;
  }

  /// Border radius per immagini arrotondate piccole
  static double getSmallImageBorderRadius(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 8,
      tabletSize: 10,
      desktopSize: 12,
    );
  }

  /// Border radius per immagini arrotondate medie
  static double getMediumImageBorderRadius(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 12,
      tabletSize: 16,
      desktopSize: 20,
    );
  }

  /// Border radius per immagini arrotondate grandi
  static double getLargeImageBorderRadius(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 16,
      tabletSize: 20,
      desktopSize: 24,
    );
  }

  // ==================== SPACING E PADDING ====================

  /// Spacing tra immagini in una griglia
  static double getImageGridSpacing(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 8,
      tabletSize: 12,
      desktopSize: 16,
    );
  }

  /// Padding per contenitori di immagini
  static EdgeInsets getImageContainerPadding(BuildContext context) {
    final padding = getResponsiveSize(
      context,
      mobileSize: 8,
      tabletSize: 12,
      desktopSize: 16,
    );
    return EdgeInsets.all(padding);
  }

  /// Margin per immagini standalone
  static EdgeInsets getImageMargin(BuildContext context) {
    final margin = getResponsiveSize(
      context,
      mobileSize: 8,
      tabletSize: 12,
      desktopSize: 16,
    );
    return EdgeInsets.all(margin);
  }

  // ==================== ASPECT RATIOS ====================

  /// Aspect ratio per immagini quadrate
  static double get squareAspectRatio => 1.0;

  /// Aspect ratio per immagini 16:9 (landscape)
  static double get landscapeAspectRatio => 16 / 9;

  /// Aspect ratio per immagini 4:3
  static double get standardAspectRatio => 4 / 3;

  /// Aspect ratio per immagini 3:4 (portrait)
  static double get portraitAspectRatio => 3 / 4;

  /// Aspect ratio per banner (molto largo)
  static double get bannerAspectRatio => 3 / 1;

  // ==================== UTILITY WIDGETS ====================

  /// Crea un CircleAvatar responsive
  static Widget buildResponsiveCircleAvatar(
    BuildContext context, {
    required ImageProvider? backgroundImage,
    required double size,
    Widget? child,
    Color? backgroundColor,
  }) {
    return CircleAvatar(
      radius: size / 2,
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor,
      child: child,
    );
  }

  /// Crea un Container con immagine responsive
  static Widget buildResponsiveImageContainer(
    BuildContext context, {
    required ImageProvider image,
    required double width,
    required double height,
    BoxFit fit = BoxFit.cover,
    double? borderRadius,
    Border? border,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius != null 
            ? BorderRadius.circular(borderRadius) 
            : null,
        border: border,
        image: DecorationImage(
          image: image,
          fit: fit,
        ),
      ),
    );
  }

  /// Crea un ClipRRect con immagine responsive
  static Widget buildResponsiveClippedImage(
    BuildContext context, {
    required ImageProvider image,
    required double width,
    required double height,
    double? borderRadius,
    BoxFit fit = BoxFit.cover,
  }) {
    final radius = borderRadius ?? getMediumImageBorderRadius(context);
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image(
        image: image,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }

  /// Crea un AspectRatio widget con immagine responsive
  static Widget buildResponsiveAspectRatioImage(
    BuildContext context, {
    required ImageProvider image,
    required double aspectRatio,
    BoxFit fit = BoxFit.cover,
    double? borderRadius,
  }) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: borderRadius != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Image(
                image: image,
                fit: fit,
              ),
            )
          : Image(
              image: image,
              fit: fit,
            ),
    );
  }

  // ==================== GRID UTILITIES ====================

  /// Ottiene il numero di colonne per una griglia di immagini
  static int getImageGridColumns(BuildContext context) {
    return getResponsiveSize(
      context,
      mobileSize: 2,
      tabletSize: 3,
      desktopSize: 4,
    ).round();
  }

  /// Ottiene il cross axis count per GridView.builder
  static int getGridViewCrossAxisCount(BuildContext context, {
    int? mobileColumns,
    int? tabletColumns,
    int? desktopColumns,
  }) {
    return getResponsiveSize(
      context,
      mobileSize: (mobileColumns ?? 2).toDouble(),
      tabletSize: (tabletColumns ?? 3).toDouble(),
      desktopSize: (desktopColumns ?? 4).toDouble(),
    ).round();
  }

  /// Ottiene il child aspect ratio per GridView
  static double getGridViewChildAspectRatio(BuildContext context, {
    double mobileRatio = 1.0,
    double tabletRatio = 1.0,
    double desktopRatio = 1.0,
  }) {
    return getResponsiveSize(
      context,
      mobileSize: mobileRatio,
      tabletSize: tabletRatio,
      desktopSize: desktopRatio,
    );
  }
}