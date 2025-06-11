import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_project/bloc/Registration_Cubit/register_cubit.dart';
import 'app_navigation.dart';
import 'bloc/Character_Bloc/character_bloc.dart';
import 'bloc/Favorits_Cubit/favorits_cubit.dart';
import 'bloc/Auth_Cubit/auth_cubit.dart';
import 'bloc/Login_Cubit/login_cubit.dart';
import 'firebase_service/firebase_options.dart';
import 'screens/auth_screen.dart';
import 'screens/navigation_screen.dart';
import 'themes/firefly_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => CharacterBloc(),
        ),
        BlocProvider<FavoritesCubit>(
          create: (context) => FavoritesCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'HSR Stats Calculator',
        theme: FireflyTheme.theme,
        debugShowCheckedModeBanner: false,
        home: const AppNavigator(),
        routes: {
          '/auth': (context) => const AuthScreen(),
          '/navigation': (context) => const NavigationScreen(),
        },
      ),
    );
  }
}

