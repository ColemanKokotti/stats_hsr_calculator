import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/MyCharacters_Cubit/my_characters_cubit.dart';
import '../../themes/firefly_theme.dart';

class SaveCollectionButton extends StatelessWidget {
  final Set<String> selectedCharacterIds;

  const SaveCollectionButton({
    super.key,
    required this.selectedCharacterIds,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 60,
        child: ElevatedButton(
          onPressed: selectedCharacterIds.isNotEmpty 
              ? () => context.read<MyCharactersCubit>().saveSelectedCharacters()
              : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: FireflyTheme.turquoise,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.save_alt,
                color: FireflyTheme.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}