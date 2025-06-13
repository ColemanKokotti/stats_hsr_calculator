import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 10,
      child: Container(
        decoration: BoxDecoration(
          color: FireflyTheme.jacket.withOpacity(0.3),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: FireflyTheme.gold.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: FireflyTheme.gold,
            size: 28,
          ),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        ),
      ),
    );
  }
}