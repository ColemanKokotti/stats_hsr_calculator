import 'package:flutter/material.dart';
import '../../screens/settings_screen.dart';
import '../../themes/firefly_theme.dart';
import '../../themes/responsive_utils.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonSize = ResponsiveImageUtils.getResponsiveSize(
      context,
      mobileSize: 50,
      tabletSize: 55,
      desktopSize: 60,
    );
    
    final iconSize = ResponsiveImageUtils.getResponsiveSize(
      context,
      mobileSize: 28,
      tabletSize: 32,
      desktopSize: 36,
    );

    return Positioned(
      top: 20,
      right: 20,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
          );
        },
        child: Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            color: FireflyTheme.jacket.withOpacity(0.7),
            borderRadius: BorderRadius.circular(buttonSize / 2),
            border: Border.all(
              color: FireflyTheme.gold.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: ResponsiveUtils.getResponsiveValue(
                  context,
                  mobileValue: 3,
                  tabletValue: 4,
                  desktopValue: 5,
                ),
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.settings,
            color: FireflyTheme.gold,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}