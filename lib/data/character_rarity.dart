import 'package:flutter/material.dart';
import '../themes/firefly_theme.dart';

class CharacterUtils {
  static String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static Color getRarityColor(int rarity) {
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
}