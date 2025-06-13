/// File centrale per importare tutte le utility responsive
/// 
/// Questo file permette di importare tutte le utility responsive
/// con un singolo import, semplificando l'uso nell'app.
/// 
/// Usage:
/// ```dart
/// import 'package:your_app/themes/responsive_utils.dart';
/// 
/// // Poi puoi usare direttamente:
/// ResponsiveTextUtils.getHeadlineLargeStyle(context)
/// ResponsiveImageUtils.getMediumAvatarSize(context)
/// ResponsiveUtils.isMobile(context)  // funzioni comuni
/// ```

library responsive_utils;

// Export delle utility specifiche
export 'responsive_text_utils.dart';
export 'responsive_image_utils.dart';

import 'package:flutter/material.dart';

/// Utility generali per la responsività che si applicano sia a testi che immagini
class ResponsiveUtils {
  // Breakpoints standard (uguali per tutti)
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  /// Verifica se lo schermo è mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  /// Verifica se lo schermo è tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  /// Verifica se lo schermo è desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }

  /// Ottiene la larghezza dello schermo
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Ottiene l'altezza dello schermo
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Ottiene le dimensioni dello schermo
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Ottiene una percentuale della larghezza dello schermo
  static double getScreenWidthPercentage(BuildContext context, double percentage) {
    return getScreenWidth(context) * (percentage / 100);
  }

  /// Ottiene una percentuale dell'altezza dello schermo
  static double getScreenHeightPercentage(BuildContext context, double percentage) {
    return getScreenHeight(context) * (percentage / 100);
  }

  /// Ottiene una dimensione responsive generica
  static double getResponsiveValue(
    BuildContext context, {
    required double mobileValue,
    required double tabletValue,
    required double desktopValue,
  }) {
    if (isMobile(context)) return mobileValue;
    if (isTablet(context)) return tabletValue;
    return desktopValue;
  }

  /// Ottiene un valore intero responsive
  static int getResponsiveIntValue(
    BuildContext context, {
    required int mobileValue,
    required int tabletValue,
    required int desktopValue,
  }) {
    if (isMobile(context)) return mobileValue;
    if (isTablet(context)) return tabletValue;
    return desktopValue;
  }

  /// Ottiene un EdgeInsets responsive
  static EdgeInsets getResponsiveEdgeInsets(
    BuildContext context, {
    required EdgeInsets mobileInsets,
    required EdgeInsets tabletInsets,
    required EdgeInsets desktopInsets,
  }) {
    if (isMobile(context)) return mobileInsets;
    if (isTablet(context)) return tabletInsets;
    return desktopInsets;
  }

  /// Ottiene un BorderRadius responsive
  static BorderRadius getResponsiveBorderRadius(
    BuildContext context, {
    required double mobileRadius,
    required double tabletRadius,
    required double desktopRadius,
  }) {
    final radius = getResponsiveValue(
      context,
      mobileValue: mobileRadius,
      tabletValue: tabletRadius,
      desktopValue: desktopRadius,
    );
    return BorderRadius.circular(radius);
  }

  /// Verifica se l'orientamento è landscape
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Verifica se l'orientamento è portrait
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Ottiene il tipo di dispositivo come stringa (per debug)
  static String getDeviceTypeString(BuildContext context) {
    if (isMobile(context)) return 'Mobile';
    if (isTablet(context)) return 'Tablet';
    return 'Desktop';
  }

  /// Ottiene informazioni complete sul dispositivo (per debug)
  static Map<String, dynamic> getDeviceInfo(BuildContext context) {
    final size = getScreenSize(context);
    return {
      'deviceType': getDeviceTypeString(context),
      'screenWidth': size.width,
      'screenHeight': size.height,
      'orientation': isLandscape(context) ? 'Landscape' : 'Portrait',
      'isMobile': isMobile(context),
      'isTablet': isTablet(context),
      'isDesktop': isDesktop(context),
    };
  }

  // ==================== PADDING E MARGIN STANDARD ====================

  /// Padding standard responsive per i contenitori principali
  static EdgeInsets getStandardContainerPadding(BuildContext context) {
    return getResponsiveEdgeInsets(
      context,
      mobileInsets: const EdgeInsets.all(16),
      tabletInsets: const EdgeInsets.all(24),
      desktopInsets: const EdgeInsets.all(32),
    );
  }

  /// Padding standard responsive per le card
  static EdgeInsets getStandardCardPadding(BuildContext context) {
    return getResponsiveEdgeInsets(
      context,
      mobileInsets: const EdgeInsets.all(12),
      tabletInsets: const EdgeInsets.all(16),
      desktopInsets: const EdgeInsets.all(20),
    );
  }

  /// Margin standard responsive tra gli elementi
  static EdgeInsets getStandardElementMargin(BuildContext context) {
    return getResponsiveEdgeInsets(
      context,
      mobileInsets: const EdgeInsets.symmetric(vertical: 8),
      tabletInsets: const EdgeInsets.symmetric(vertical: 12),
      desktopInsets: const EdgeInsets.symmetric(vertical: 16),
    );
  }

  /// Spaziatura standard responsive tra le sezioni
  static double getStandardSectionSpacing(BuildContext context) {
    return getResponsiveValue(
      context,
      mobileValue: 24,
      tabletValue: 32,
      desktopValue: 40,
    );
  }

  /// Spaziatura standard responsive tra gli elementi
  static double getStandardElementSpacing(BuildContext context) {
    return getResponsiveValue(
      context,
      mobileValue: 12,
      tabletValue: 16,
      desktopValue: 20,
    );
  }

  /// Spaziatura piccola responsive
  static double getSmallSpacing(BuildContext context) {
    return getResponsiveValue(
      context,
      mobileValue: 4,
      tabletValue: 6,
      desktopValue: 8,
    );
  }

  /// Spaziatura grande responsive
  static double getLargeSpacing(BuildContext context) {
    return getResponsiveValue(
      context,
      mobileValue: 20,
      tabletValue: 28,
      desktopValue: 36,
    );
  }

  // ==================== UTILITY WIDGETS ====================

  /// Crea un SizedBox con altezza responsive
  static Widget responsiveVerticalSpace(BuildContext context, {
    double mobileHeight = 16,
    double tabletHeight = 20,
    double desktopHeight = 24,
  }) {
    return SizedBox(
      height: getResponsiveValue(
        context,
        mobileValue: mobileHeight,
        tabletValue: tabletHeight,
        desktopValue: desktopHeight,
      ),
    );
  }

  /// Crea un SizedBox con larghezza responsive
  static Widget responsiveHorizontalSpace(BuildContext context, {
    double mobileWidth = 16,
    double tabletWidth = 20,
    double desktopWidth = 24,
  }) {
    return SizedBox(
      width: getResponsiveValue(
        context,
        mobileValue: mobileWidth,
        tabletValue: tabletWidth,
        desktopValue: desktopWidth,
      ),
    );
  }

  /// Crea un Divider responsive
  static Widget responsiveDivider(BuildContext context) {
    return Padding(
      padding: getStandardElementMargin(context),
      child: Divider(
        thickness: getResponsiveValue(
          context,
          mobileValue: 1,
          tabletValue: 1.5,
          desktopValue: 2,
        ),
      ),
    );
  }
}