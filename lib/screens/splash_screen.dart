import 'package:flutter/material.dart';
import '../themes/firefly_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: FireflyTheme.backgroundGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo or icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: FireflyTheme.goldGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: FireflyTheme.gold.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.fireplace,
                    size: 60,
                    color: FireflyTheme.jacket,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              // App name with gradient text
              FireflyTheme.gradientText(
                'HSR Stats Calculator',
                gradient: FireflyTheme.goldGradient,
                style: TextStyle(
                  color: FireflyTheme.white.withOpacity(0.8),
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),


              const SizedBox(height: 60),
              
              // Loading indicator
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(FireflyTheme.turquoise),
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}