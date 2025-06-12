import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/character_model.dart';
import '../../../themes/firefly_theme.dart';
import '../../../widgets/home_screen_widgets/character_card_widget.dart';
import '../../../bloc/MyCharacters_Cubit/my_characters_list_cubit.dart';
import '../../../bloc/MyCharacters_Cubit/my_characters_list_state.dart';


class MyCharactersList extends StatelessWidget {
  final List<String> selectedCharacterIds;
  final VoidCallback onAddCharacter;

  const MyCharactersList({
    super.key,
    required this.selectedCharacterIds,
    required this.onAddCharacter,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyCharactersListCubit()..loadMyCharacters(selectedCharacterIds),
      child: _MyCharactersListContent(
        selectedCharacterIds: selectedCharacterIds,
        onAddCharacter: onAddCharacter,
      ),
    );
  }
}

class _MyCharactersListContent extends StatelessWidget {
  final List<String> selectedCharacterIds;
  final VoidCallback onAddCharacter;

  const _MyCharactersListContent({
    required this.selectedCharacterIds,
    required this.onAddCharacter,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyCharactersListCubit, MyCharactersListState>(
      listener: (context, state) {
        if (state is MyCharactersListError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        // When selectedCharacterIds changes, reload the characters
        if (state is MyCharactersListLoaded && 
            !_areListsEqual(selectedCharacterIds, state.myCharacters.map((c) => c.id).toList())) {
          context.read<MyCharactersListCubit>().loadMyCharacters(selectedCharacterIds);
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Characters',
                style: TextStyle(
                  color: FireflyTheme.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _buildContent(context, state),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, MyCharactersListState state) {
    if (state is MyCharactersListLoading || state is MyCharactersListInitial) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is MyCharactersListLoaded) {
      return state.myCharacters.isEmpty
          ? _buildEmptyState()
          : _buildCharactersList(state.myCharacters);
    } else {
      return Center(
        child: Text(
          'Something went wrong',
          style: TextStyle(color: FireflyTheme.white),
        ),
      );
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: FireflyTheme.white.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No characters selected yet',
            style: TextStyle(
              color: FireflyTheme.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onAddCharacter,
            style: ElevatedButton.styleFrom(
              backgroundColor: FireflyTheme.turquoise,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Add Characters'),
          ),
        ],
      ),
    );
  }

  Widget _buildCharactersList(List<Character> myCharacters) {
    return ListView.builder(
      itemCount: myCharacters.length + 1, // +1 for the add button
      itemBuilder: (context, index) {
        if (index == myCharacters.length) {
          return _buildAddCharacterCard();
        }
        
        final character = myCharacters[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CharacterCard(
            character: character,
            onTap: () {
              // Navigate to character details
              // This would typically navigate to your character detailed screen
            },
          ),
        );
      },
    );
  }

  Widget _buildAddCharacterCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          gradient: FireflyTheme.cardGradient.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: FireflyTheme.turquoise.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onAddCharacter,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline,
                  size: 48,
                  color: FireflyTheme.turquoise,
                ),
                const SizedBox(height: 12),
                Text(
                  'Add Character',
                  style: TextStyle(
                    color: FireflyTheme.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to compare lists
  bool _areListsEqual(List<String> list1, List<String> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (!list2.contains(list1[i])) return false;
    }
    return true;
  }
}