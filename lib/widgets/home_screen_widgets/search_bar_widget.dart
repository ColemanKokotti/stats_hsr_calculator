import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Character_Bloc/character_bloc.dart';
import '../../bloc/Character_Bloc/character_event.dart';
import '../../bloc/Home_Screen_Cubit/home_screen_cubit.dart';
import '../../bloc/Home_Screen_Cubit/home_screen_state.dart';
import '../../themes/firefly_theme.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          decoration: FireflyTheme.cardDecoration,
          child: TextField(
            style: TextStyle(color: FireflyTheme.white),
            decoration: InputDecoration(
              hintText: 'Search characters...',
              hintStyle: TextStyle(color: FireflyTheme.white.withOpacity(0.6)),
              prefixIcon: Icon(Icons.search, color: FireflyTheme.turquoise),
              suffixIcon: state.searchQuery.isNotEmpty
                  ? IconButton(
                onPressed: () {
                  context.read<HomeCubit>().clearSearch();
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
              context.read<HomeCubit>().updateSearchQuery(value);
              context.read<CharacterBloc>().add(SearchCharacters(value));
            },
          ),
        );
      },
    );
  }
}