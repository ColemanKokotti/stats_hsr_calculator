import 'package:flutter/material.dart';
import '../../themes/firefly_theme.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget expandedContent;
  final String? subtitle;

  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.isExpanded,
    required this.onToggle,
    required this.expandedContent,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: FireflyTheme.cardGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: FireflyTheme.gold,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: FireflyTheme.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (subtitle != null)
                            Text(
                              subtitle!,
                              style: TextStyle(
                                color: FireflyTheme.white.withOpacity(0.7),
                                fontSize: 14,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: FireflyTheme.white,
                    ),
                  ],
                ),
                if (isExpanded) ...[
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 16),
                  expandedContent,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}