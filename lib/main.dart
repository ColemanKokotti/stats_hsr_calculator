import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/Character_Bloc/character_bloc.dart';
import 'screens/splash_screen.dart';
import 'screens/navigation_screen.dart';
import 'themes/firefly_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
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