import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../themes/firefly_theme.dart';
import '../bloc/MyCharacters_Cubit/my_characters_cubit.dart';
import '../widgets/my_characters_widgets/my_characters_content.dart';

class MyCharactersScreen extends StatelessWidget {
  const MyCharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyCharactersCubit()..loadData(),
      child: const _MyCharactersScreenContent(),
    );
  }
}

class _MyCharactersScreenContent extends StatelessWidget {
  const _MyCharactersScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FireflyTheme.gradientText(
          'My Characters',
          gradient: FireflyTheme.eyesGradient,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: FireflyTheme.jacket,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: FireflyTheme.backgroundGradient),
        child: const MyCharactersContent(),
      ),
    );
  }
}