import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/character_model.dart';
import '../../themes/firefly_theme.dart';
import '../bloc/Character_Detailed_Cubit/character_detailed_cubit.dart';
import '../bloc/Character_Detailed_Cubit/character_detailed_state.dart';
import '../widgets/character_detailed_screen_widgets/character_icon_widget.dart';
import '../widgets/character_detailed_screen_widgets/character_info_container.dart';
import '../widgets/character_detailed_screen_widgets/character_portrait_widget.dart';


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
      child: CharacterDetailView(),
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
            if (state is CharacterDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CharacterDetailError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red.withOpacity(0.7),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading character details',
                      style: TextStyle(
                        color: FireflyTheme.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: TextStyle(
                        color: FireflyTheme.white.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: FireflyTheme.turquoise,
                        foregroundColor: FireflyTheme.jacket,
                      ),
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              );
            }

            if (state is CharacterDetailLoaded) {
              return CustomScrollView(
                slivers: [
                  // App Bar con nome e icona
                  SliverAppBar(
                    expandedHeight: 100,
                    pinned: true,
                    backgroundColor: FireflyTheme.jacket.withOpacity(0.9),
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        state.character.name,
                        style: TextStyle(
                          color: FireflyTheme.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                        ),
                      ),
                      centerTitle: true,
                      titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: CharacterIconWidget(character: state.character),
                      ),
                    ],
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: FireflyTheme.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  // Content
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        // Portrait centrale
                        Center(
                          child: CharacterPortraitWidget(
                            character: state.character,
                            size: 250,
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Container con informazioni
                        CharacterInfoContainerWidget(
                          character: state.character,
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}