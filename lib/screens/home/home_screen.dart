import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Character_Bloc/character_bloc.dart';
import '../../bloc/Character_Bloc/character_event.dart';
import '../../bloc/Character_Bloc/character_state.dart';
import '../../themes/firefly_theme.dart';
import '../../widgets/character_card_widget.dart';
import '../../widgets/character_filters_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(const LoadCharacters());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: FireflyTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header con titolo e ricerca
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    FireflyTheme.gradientText(
                      'Characters',
                      gradient: FireflyTheme.eyesGradient,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Barra di ricerca
                    Container(
                      decoration: FireflyTheme.cardDecoration,
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(color: FireflyTheme.white),
                        decoration: InputDecoration(
                          hintText: 'Search characters...',
                          hintStyle: TextStyle(color: FireflyTheme.white.withOpacity(0.6)),
                          prefixIcon: Icon(Icons.search, color: FireflyTheme.turquoise),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                            onPressed: () {
                              _searchController.clear();
                              context.read<CharacterBloc>().add(const SearchCharacters(''));
                            },
                            icon: Icon(Icons.clear, color: FireflyTheme.white),
                          )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        onChanged: (value) {
                          context.read<CharacterBloc>().add(SearchCharacters(value));
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Filtri
              const CharacterFilters(),
              // Lista personaggi
              Expanded(
                child: BlocBuilder<CharacterBloc, CharacterState>(
                  builder: (context, state) {
                    if (state is CharacterLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: FireflyTheme.turquoise,
                        ),
                      );
                    }

                    if (state is CharacterError) {
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
                              'Error loading characters',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: FireflyTheme.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.message,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: FireflyTheme.white.withOpacity(0.7),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<CharacterBloc>().add(const LoadCharacters());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: FireflyTheme.turquoise,
                                foregroundColor: FireflyTheme.jacket,
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is CharacterLoaded) {
                      if (state.filteredCharacters.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: FireflyTheme.white.withOpacity(0.5),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No characters found',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: FireflyTheme.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Try adjusting your search or filters',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: FireflyTheme.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return RefreshIndicator(
                        color: FireflyTheme.turquoise,
                        backgroundColor: FireflyTheme.jacket,
                        onRefresh: () async {
                          context.read<CharacterBloc>().add(const RefreshCharacters());
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemCount: state.filteredCharacters.length,
                          itemBuilder: (context, index) {
                            final character = state.filteredCharacters[index];
                            return CharacterCard(
                              character: character,
                              onTap: () {
                                // TODO: Navigate to character detail
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${character.name} tapped!'),
                                    backgroundColor: FireflyTheme.turquoise,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}