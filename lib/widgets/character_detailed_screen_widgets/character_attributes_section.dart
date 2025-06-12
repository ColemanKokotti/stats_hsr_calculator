import 'package:flutter/material.dart';
import '../../data/character_model.dart';
import '../../themes/firefly_theme.dart';
import 'character_element_widget.dart';
import 'character_path_widget.dart';

class CharacterAttributesSection extends StatelessWidget {
  final Character character;

  const CharacterAttributesSection({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildAttributeColumn(
          title: 'Element',
          child: CharacterElementWidget(element: character.element),
        ),
        _buildAttributeColumn(
          title: 'Path',
          child: CharacterPathWidget(character: character),
        ),
      ],
    );
  }

  Widget _buildAttributeColumn({
    required String title,
    required Widget child,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: FireflyTheme.white.withOpacity(0.8),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}