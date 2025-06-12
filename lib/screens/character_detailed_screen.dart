import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/character_model.dart';
import '../themes/firefly_theme.dart';
import '../bloc/Character_Detailed_Cubit/character_detailed_cubit.dart';
import '../bloc/Character_Detailed_Cubit/character_detailed_state.dart';
import '../widgets/character_detailed_screen_widgets/character_content_widget.dart';
import '../widgets/character_detailed_screen_widgets/character_error_widget.dart';
import '../widgets/character_detailed_screen_widgets/character_loading_widget.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailScreen({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterDetailCubit()..loadCharacterFromData(character),
      child: const CharacterDetailView(),
    );
  }
}

class CharacterDetailView extends StatelessWidget {
  const CharacterDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: FireflyTheme.backgroundGradient),
        child: BlocBuilder<CharacterDetailCubit, CharacterDetailState>(
          builder: (context, state) {
            return _buildContent(state);
          },
        ),
      ),
    );
  }

  Widget _buildContent(CharacterDetailState state) {
    if (state is CharacterDetailLoading) {
      return const CharacterLoadingWidget();
    }

    if (state is CharacterDetailError) {
      return CharacterErrorWidget(errorMessage: state.message);
    }

    if (state is CharacterDetailLoaded) {
      return CharacterContentWidget(character: state.character);
    }

    return const SizedBox.shrink();
  }
}