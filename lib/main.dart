import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/Character_Bloc/character_bloc.dart';
import 'bloc/Favorits_Cubit/favorits_cubit.dart';
import 'screens/splash_screen.dart';
import 'screens/navigation_screen.dart';
import 'themes/firefly_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CharacterBloc(),
        ),
        BlocProvider<FavoritesCubit>(
          create: (context) => FavoritesCubit(),
        ),
        BlocProvider<FavoritesCubit>(
          create: (context) => FavoritesCubit(),
        ),
      ],child: MaterialApp(
    title: 'HSR Stats Calculator',
    theme: FireflyTheme.theme,
    debugShowCheckedModeBanner: false,
    home: const SplashScreen(),
    routes: {
    '/navigation': (context) => const NavigationScreen(),
    },
    ),
    );
  }
}