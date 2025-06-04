import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/character_model.dart';
import '../../data/character_stats.dart';
import '../../data/api_stats_service.dart';
import '../../themes/firefly_theme.dart';
import '../bloc/Character_Detailed_Cubit/character_detailed_cubit.dart';
import '../bloc/Character_Detailed_Cubit/character_detailed_state.dart';
import '../widgets/character_stats_screen_widgets/character_stats_icon.dart';
import '../widgets/character_stats_screen_widgets/character_stats_portrait.dart';
import '../widgets/character_stats_screen_widgets/character_stats_container.dart';

class CharacterStatsScreen extends StatelessWidget {
  final Character character;

  const CharacterStatsScreen({
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

class CharacterDetailView extends StatefulWidget {
  const CharacterDetailView({super.key});

  @override
  State<CharacterDetailView> createState() => _CharacterDetailViewState();
}

class _CharacterDetailViewState extends State<CharacterDetailView> {
  CharacterStats? characterStats;
  bool isLoadingStats = true;
  String? statsError;

  @override
  void initState() {
    super.initState();
    _loadCharacterStats();
  }

  Future<void> _loadCharacterStats() async {
    try {
      setState(() {
        isLoadingStats = true;
        statsError = null;
      });

      final stats = await ApiStatsService.getCharacterStatsById(
        context.read<CharacterDetailCubit>().state is CharacterDetailLoaded
            ? (context.read<CharacterDetailCubit>().state as CharacterDetailLoaded).character.id
            : '',
      );

      if (mounted) {
        setState(() {
          characterStats = stats;
          isLoadingStats = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          statsError = 'Failed to load character stats: $e';
          isLoadingStats = false;
        });
      }
    }
  }

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
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: FireflyTheme.jacket.withOpacity(0.9),
                    automaticallyImplyLeading: false,
                      title: Text(
                        state.character.name,
                        style: TextStyle(
                            color: FireflyTheme.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12
                        ),
                      ),
                      centerTitle: true,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: CharacterStatsIcon(character: state.character),
                      ),
                    ],
                  ),
                  // Content
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        // Portrait centrale
                        Center(
                          child: CharacterStatsPortrait(
                            character: state.character,
                            size: 250,
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Container con informazioni base
                        isLoadingStats
                            ? Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(40),
                          decoration: FireflyTheme.cardDecoration.copyWith(
                            boxShadow: [
                              BoxShadow(
                                color: FireflyTheme.turquoise.withOpacity(0.1),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                CircularProgressIndicator(
                                  color: FireflyTheme.turquoise,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Loading statistics...',
                                  style: TextStyle(
                                    color: FireflyTheme.white.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                            : CharacterStatsContainerWidget(
                          character: state.character,
                          stats: characterStats,
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