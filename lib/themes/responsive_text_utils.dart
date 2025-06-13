import 'package:flutter/material.dart';

/// Utility class per gestire le dimensioni dei testi in modo responsive
class ResponsiveTextUtils {
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

  /// Ottiene la dimensione del testo basata sui breakpoints
  static double getResponsiveTextSize(
    BuildContext context, {
    required double mobileSize,
    required double tabletSize,
    required double desktopSize,
  }) {
    if (isMobile(context)) return mobileSize;
    if (isTablet(context)) return tabletSize;
    return desktopSize;
  }

  // ==================== TEXT SIZES ====================

  /// Display Large - per titoli principali
  static double getDisplayLargeSize(BuildContext context) {
    return getResponsiveTextSize(
      context,
      mobileSize: 32,
      tabletSize: 40,
      desktopSize: 48,
    );
  }

  /// Display Medium - per titoli sezioni importanti
  static double getDisplayMediumSize(BuildContext context) {
    return getResponsiveTextSize(
      context,
      mobileSize: 28,
      tabletSize: 34,
      desktopSize: 40,
    );
  }

  /// Display Small - per sottotitoli principali
  static double getDisplaySmallSize(BuildContext context) {
    return getResponsiveTextSize(
      context,
      mobileSize: 24,
      tabletSize: 28,
      desktopSize: 32,
    );
  }

  /// Headline Large - per intestazioni grandi
  static double getHeadlineLargeSize(BuildContext context) {
    return getResponsiveTextSize(
      context,
      mobileSize: 22,
      tabletSize: 26,
      desktopSize: 30,
    );
  }

  /// Headline Medium - per intestazioni medie
  static double getHeadlineMediumSize(BuildContext context) {
    return getResponsiveTextSize(
      context,
      mobileSize: 20,
      tabletSize: 22,
      desktopSize: 26,
    );
  }

  /// Headline Small - per intestazioni piccole
  static double getHeadlineSmallSize(BuildContext context) {
    return getResponsiveTextSize(
      context,
      mobileSize: 18,
      tabletSize: 20,
      desktopSize: 22,
    );
  }

  /// Title Large - per titoli di contenuto
  static double getTitleLargeSize(BuildContext context) {
    return getResponsiveTextSize(
      context,
      mobileSize: 16,
      tabletSize: 18,
      desktopSize: 20,
    );
  }

  /// Title Medium - per titoli di sezioni
  static double getTitleMediumSize(BuildContext context) {
    return getResponsiveTextSize(
      context,
      mobileSize: 14,
      tabletSize: 16,
      desktopSize: 18,
    );
  }

  /// Title Small - per piccoli titoli
  static double getTitleSmallSize(BuildContext context) {
    return getResponsiveTextSize(
      context,
      mobileSize: 13,
      tabletSize: 14,
      desktopSize: 16,
    );
  }

  /// Body Large - per testo del corpo principale
  static double getBodyLargeSize(BuildContext context) {
    return getResponsiveTextSize(
      context,
      mobileSize: 14,
      tabletSize: 15,
      desktopSize: 16,
    );
  }

  /// Body Medium - per testo del corpo standard
  static double getBodyMediumSize(BuildContext context) {
    return getResponsiveTextSize(
      context,
      mobileSize: 12,
      tabletSize: 13,
      desktopSize: 14,
    );
  }

  /// Body Small - per testo piccolo
  static double getBodySmallSize(BuildContext context) {
    return getResponsiveTextSize(
      context,
      mobileSize: 11,
      tabletSize: 12,
      desktopSize: 13,
    );
  }

  /// Label Large - per etichette principali
  static double getLabelLargeSize(BuildContext context) {
    return getResponsiveTextSize(
      context,
      mobileSize: 12,
      tabletSize: 13,
      desktopSize: 14,
    );
  }

  /// Label Medium - per etichette standard
  static double getLabelMediumSize(BuildContext context) {
    return getResponsiveTextSize(
      context,
      mobileSize: 11,
      tabletSize: 12,
      desktopSize: 13,
    );
  }

  /// Label Small - per piccole etichette
  static double getLabelSmallSize(BuildContext context) {
    return getResponsiveTextSize(
      context,
      mobileSize: 10,
      tabletSize: 11,
      desktopSize: 12,
    );
  }

  // ==================== TEXT STYLES ====================

  /// Crea uno stile di testo responsive per Display Large
  static TextStyle getDisplayLargeStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: getDisplayLargeSize(context),
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  /// Crea uno stile di testo responsive per Display Medium
  static TextStyle getDisplayMediumStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: getDisplayMediumSize(context),
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  /// Crea uno stile di testo responsive per Display Small
  static TextStyle getDisplaySmallStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: getDisplaySmallSize(context),
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  /// Crea uno stile di testo responsive per Headline Large
  static TextStyle getHeadlineLargeStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: getHeadlineLargeSize(context),
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  /// Crea uno stile di testo responsive per Headline Medium
  static TextStyle getHeadlineMediumStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: getHeadlineMediumSize(context),
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  /// Crea uno stile di testo responsive per Headline Small
  static TextStyle getHeadlineSmallStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: getHeadlineSmallSize(context),
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  /// Crea uno stile di testo responsive per Title Large
  static TextStyle getTitleLargeStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: getTitleLargeSize(context),
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  /// Crea uno stile di testo responsive per Title Medium
  static TextStyle getTitleMediumStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: getTitleMediumSize(context),
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  /// Crea uno stile di testo responsive per Title Small
  static TextStyle getTitleSmallStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: getTitleSmallSize(context),
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  /// Crea uno stile di testo responsive per Body Large
  static TextStyle getBodyLargeStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: getBodyLargeSize(context),
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  /// Crea uno stile di testo responsive per Body Medium
  static TextStyle getBodyMediumStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: getBodyMediumSize(context),
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  /// Crea uno stile di testo responsive per Body Small
  static TextStyle getBodySmallStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: getBodySmallSize(context),
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  /// Crea uno stile di testo responsive per Label Large
  static TextStyle getLabelLargeStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: getLabelLargeSize(context),
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  /// Crea uno stile di testo responsive per Label Medium
  static TextStyle getLabelMediumStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: getLabelMediumSize(context),
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  /// Crea uno stile di testo responsive per Label Small
  static TextStyle getLabelSmallStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      fontSize: getLabelSmallSize(context),
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  // ==================== SPACING UTILITIES ====================

  /// Ottiene la spaziatura verticale responsive per i testi
  static double getTextVerticalSpacing(BuildContext context, {
    double mobileSpacing = 8,
    double tabletSpacing = 12,
    double desktopSpacing = 16,
  }) {
    return getResponsiveTextSize(
      context,
      mobileSize: mobileSpacing,
      tabletSize: tabletSpacing,
      desktopSize: desktopSpacing,
    );
  }

  /// Ottiene la spaziatura orizzontale responsive per i testi
  static double getTextHorizontalSpacing(BuildContext context, {
    double mobileSpacing = 12,
    double tabletSpacing = 16,
    double desktopSpacing = 20,
  }) {
    return getResponsiveTextSize(
      context,
      mobileSize: mobileSpacing,
      tabletSize: tabletSpacing,
      desktopSize: desktopSpacing,
    );
  }

  /// Ottiene il padding responsive per i contenitori di testo
  static EdgeInsets getTextContainerPadding(BuildContext context) {
    final horizontal = getTextHorizontalSpacing(context);
    final vertical = getTextVerticalSpacing(context);
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }
}