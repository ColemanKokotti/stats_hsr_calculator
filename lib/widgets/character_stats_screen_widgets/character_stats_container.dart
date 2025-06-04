import 'package:flutter/material.dart';
import 'package:help_project/widgets/character_stats_screen_widgets/stats_header.dart';
import 'package:help_project/widgets/character_stats_screen_widgets/stats_item.dart';
import '../../data/character_model.dart';
import '../../data/character_stats.dart';
import '../../themes/firefly_theme.dart';
import 'empty_stats_widget.dart';

class CharacterStatsContainerWidget extends StatelessWidget {
  final Character character;
  final CharacterStats? stats;

  const CharacterStatsContainerWidget({
    super.key,
    required this.character,
    this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: FireflyTheme.cardDecoration.copyWith(
        boxShadow: [
          BoxShadow(
            color: FireflyTheme.turquoise.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: stats == null
          ? const EmptyStatsWidget()
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const StatsHeader(),
            const SizedBox(height: 20),
            _buildStatsGrid(),
            if (stats!.ultCost != null) ...[
              const SizedBox(height: 20),
              _buildUltimateCost(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Column(
      children: [
        // Prima riga: HP e ATK
        Row(
          children: [
            Expanded(
              child: StatItem(
                label: 'HP',
                value: stats!.hp.toString(),
                icon: Icons.favorite,
                color: const Color(0xFF4CAF50),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatItem(
                label: 'ATK',
                value: stats!.atk.toString(),
                icon: Icons.flash_on,
                color: const Color(0xFFF44336),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Seconda riga: DEF e SPD
        Row(
          children: [
            Expanded(
              child: StatItem(
                label: 'DEF',
                value: stats!.def.toString(),
                icon: Icons.shield,
                color: const Color(0xFF2196F3),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatItem(
                label: 'SPD',
                value: stats!.spd.toString(),
                icon: Icons.speed,
                color: const Color(0xFFFF9800),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatItem(
                label: 'Crit Rate',
                value: stats!.critRate.toString(),
                icon: Icons.bolt,
                color: const Color(0xFFE91E63),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatItem(
                label: 'Crit DMG',
                value: stats!.critDmg.toString(),
                icon: Icons.whatshot,
                color: const Color(0xFF673AB7),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUltimateCost() {
    return StatItem(
      label: 'Ultimate Cost',
      value: stats!.ultCost.toString(),
      icon: Icons.star,
      color: const Color(0xFF9C27B0),
      isFullWidth: true,
    );
  }

}