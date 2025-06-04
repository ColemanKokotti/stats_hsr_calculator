import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/Character_Bloc/character_bloc.dart';
import '../bloc/Character_Bloc/character_event.dart';
import '../bloc/Home_Screen_Cubit/home_screen_cubit.dart';
import '../themes/firefly_theme.dart';
import '../widgets/filter_widgets/character_filters_widget.dart';
import '../widgets/firebase_upload_widgets/firebase_button.dart';
import '../widgets/home_screen_widgets/character_list_widget.dart';
import '../widgets/home_screen_widgets/home_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    // Load characters when the screen is built
    context.read<CharacterBloc>().add(const LoadCharacters());

    return Scaffold(
      appBar: AppBar(
        actions: const [
          FirebaseButton(), // Aggiunto il bottone qui
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: FireflyTheme.backgroundGradient),
        child: const SafeArea(
          child: Column(
            children: [
              HomeHeaderWidget(),
              CharacterFilters(),
              Expanded(
                child: CharacterListWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}