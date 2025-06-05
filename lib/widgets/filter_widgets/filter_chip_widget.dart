import 'package:flutter/material.dart';

import '../../themes/firefly_theme.dart';


class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          // Qui applichiamo il LinearGradient
          gradient: isSelected
              ? FireflyTheme.selectedFilterGradient
              : FireflyTheme.notSelectedFilterGradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? FireflyTheme.turquoise : FireflyTheme.white.withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? FireflyTheme.jacket : FireflyTheme.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}