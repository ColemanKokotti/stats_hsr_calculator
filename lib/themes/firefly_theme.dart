import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FireflyTheme {
  // Core colors from Firefly's palette
  static const Color _hair = Color(0xFFD6D5D0); // Silver/gray
  static const Color _hairShadow = Color(0xFFBDBAB7); // Darker hair tone for shadows
  static const Color _eyes = Color(0xFF8264B1); // Purple eyes
  static const Color _eyesHighlight = Color(0xFF9B7DCA); // Lighter purple highlight in eyes
  static const Color _jacket = Color(0xFF2A2535); // Black/dark purple jacket
  static const Color _gold = Color(0xFFF5B13D); // Gold/yellow accents
  static const Color _goldHighlight = Color(0xFFFDC970); // Lighter gold highlight
  static const Color _white = Color(0xFFFFFFFF); // White
  static const Color _offWhite = Color(0xFFF5F5F5); // Slight off-white for fabric details
  static const Color _turquoise = Color(0xFF5AB0AD); // Turquoise base
  static const Color _turquoiseDark = Color(0xFF478F8D); // Darker turquoise for shadows
  static const Color _mint = Color(0xFFA8E1D2); // Mint green
  static const Color _blue = Color(0xFF71BDC7); // Light blue accents
  static const Color _crystal = Color(0xFFB3ECDF); // Crystal green effects
  static const Color _crystalHighlight = Color(0xFFD0F5EC); // Brighter crystal highlight
  static const Color _lightPurple = Color(0xFFB4A8CD); // Light purple for details
  static const Color _black = Color(0xFF1C1921); // Black accents
  static const Color _darkPurple = Color(0xFF36304A); // Dark purple for depth

  // Public getters for theme colors
  static Color get gold => _gold;
  static Color get white => _white;
  static Color get hair => _hair;
  static Color get jacket => _jacket;
  static Color get turquoise => _turquoise;
  static Color get turquoiseDark => _turquoiseDark;

  // Gradients refined to match Firefly's aesthetic
  static LinearGradient get hairGradient => const LinearGradient(
    colors: [_hair, _hairShadow, _hair],
    stops: [0.0, 0.6, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient get jacketGradient => const LinearGradient(
    colors: [_jacket, _darkPurple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static LinearGradient get outfitGradient => const LinearGradient(
    colors: [_turquoise, _mint, _crystal],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get skirtGradient => const LinearGradient(
    colors: [_turquoiseDark, _turquoise, _mint],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient get eyesGradient => const LinearGradient(
    colors: [_eyes, _eyesHighlight],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static LinearGradient get crystalGradient => const LinearGradient(
    colors: [_crystal, _crystalHighlight, _mint],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static LinearGradient get goldGradient => const LinearGradient(
    colors: [_gold, _goldHighlight],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  static LinearGradient get backgroundGradient => const LinearGradient(
    colors: [_black, _jacket, _darkPurple],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get cardGradient => LinearGradient(
    colors: [_turquoiseDark.withValues(alpha: 0.7),_jacket.withOpacity(0.8),_goldHighlight.withOpacity(0.7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get searchGradient => LinearGradient(
    colors: [_turquoiseDark.withValues(alpha: 0.7),_goldHighlight.withOpacity(0.7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get buttonGradient => const LinearGradient(
    colors: [_turquoise, _blue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static BoxDecoration get cardDecoration => BoxDecoration(
    gradient: cardGradient,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: _gold.withOpacity(0.5), width: 1),
    boxShadow: [
      BoxShadow(
        color: _black.withOpacity(0.3),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );
  static BoxDecoration get searchDecoration => BoxDecoration(
    gradient: searchGradient,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: _gold.withOpacity(0.5), width: 1),
    boxShadow: [
      BoxShadow(
        color: _black.withOpacity(0.3),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // Main theme
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: _jacket,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _jacket,
        primary: _jacket,
        secondary: _turquoise,
        tertiary: _gold,
        surface: _darkPurple,
        background: _turquoise, // Scaffold color is now turquoise
        error: const Color(0xFFE57373),
        onPrimary: _white,
        onSecondary: _black,
        onTertiary: _black,
        onSurface: _white,
        onBackground: _white,
        onError: _white,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: _turquoise, // Explicitly set scaffold background

      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: _hair, // App bar color is now hair color
        foregroundColor: _white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: _white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        iconTheme: IconThemeData(color: _gold),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _turquoiseDark, // Bottom bar color is now darker turquoise
        selectedItemColor: _gold,
        unselectedItemColor: _jacket,
        selectedIconTheme: IconThemeData(color: _gold, size: 28),
        unselectedIconTheme: IconThemeData(color: _jacket, size: 24),
        selectedLabelStyle: TextStyle(color: _gold, fontSize: 12),
        unselectedLabelStyle: TextStyle(color: _jacket, fontSize: 11),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Card theme
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: _gold.withOpacity(0.3), width: 1),
        ),
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shadowColor: _black.withOpacity(0.4),
      ),

      // Text theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: _white, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: _white, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: _white, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(color: _white, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(color: _white, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(color: _gold, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: _gold, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: _mint, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(color: _lightPurple, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: _white),
        bodyMedium: TextStyle(color: _offWhite),
        bodySmall: TextStyle(color: _lightPurple),
        labelLarge: TextStyle(color: _gold, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(color: _turquoise),
        labelSmall: TextStyle(color: _lightPurple),
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return _darkPurple.withOpacity(0.5);
            }
            return Colors.transparent;
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return _lightPurple.withOpacity(0.7);
            }
            return _white;
          }),
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: _gold, width: 1.5),
            ),
          ),
          overlayColor: MaterialStateProperty.all(_turquoise.withOpacity(0.2)),
          textStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return _lightPurple.withOpacity(0.5);
            }
            return _turquoise;
          }),
          side: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return BorderSide(color: _lightPurple.withOpacity(0.5), width: 1.5);
            }
            return BorderSide(color: _turquoise, width: 1.5);
          }),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          overlayColor: MaterialStateProperty.all(_turquoise.withOpacity(0.1)),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return _lightPurple.withOpacity(0.5);
            }
            return _gold;
          }),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(_gold.withOpacity(0.1)),
          textStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ),

      // Icons theme
      iconTheme: IconThemeData(
        color: _turquoise,
        size: 24,
      ),
      primaryIconTheme: IconThemeData(
        color: _gold,
        size: 24,
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _jacket.withOpacity(0.7),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _turquoise),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _turquoise.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _gold, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFE57373), width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFE57373), width: 2),
        ),
        hintStyle: TextStyle(color: _lightPurple.withOpacity(0.7)),
        labelStyle: TextStyle(color: _turquoise),
        errorStyle: TextStyle(color: Color(0xFFE57373), fontSize: 12),
        suffixIconColor: _turquoise,
        prefixIconColor: _turquoise,
      ),

      // Slider theme
      sliderTheme: SliderThemeData(
        activeTrackColor: _turquoise,
        inactiveTrackColor: _darkPurple,
        thumbColor: _gold,
        overlayColor: _gold.withOpacity(0.2),
        valueIndicatorColor: _jacket,
        valueIndicatorTextStyle: const TextStyle(color: _white),
      ),

      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _turquoise;
          }
          return _darkPurple;
        }),
        checkColor: WidgetStateProperty.all(_white),
        side: const BorderSide(color: _turquoise, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // Dialog theme
      dialogTheme: DialogTheme(
        backgroundColor: _jacket,
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: _gold.withOpacity(0.5), width: 1),
        ),
        titleTextStyle: const TextStyle(
          color: _gold,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: const TextStyle(
          color: _white,
          fontSize: 16,
        ),
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: _darkPurple,
        disabledColor: _darkPurple.withOpacity(0.3),
        selectedColor: _turquoise,
        secondarySelectedColor: _gold,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        labelStyle: const TextStyle(color: _white),
        secondaryLabelStyle: const TextStyle(color: _black),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: _turquoise,
        linearTrackColor: _darkPurple,
        circularTrackColor: _darkPurple,
        refreshBackgroundColor: _jacket,
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: _lightPurple.withOpacity(0.3),
        thickness: 1,
        space: 24,
      ),
    );
  }

  // Helper method to apply background gradient to scaffold
  static Widget scaffoldWithBackground({required Widget child}) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient),
      child: child,
    );
  }

  // Helper for gradient text
  static Widget gradientText(
      String text, {
        required Gradient gradient,
        TextStyle? style,
        TextAlign? textAlign,
      }) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}