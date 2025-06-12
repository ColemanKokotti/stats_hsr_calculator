import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_project/bloc/Registration_Cubit/register_cubit.dart';
import 'bloc/Character_Bloc/character_bloc.dart';
import 'bloc/Favorits_Cubit/favorits_cubit.dart';
import 'bloc/Auth_Cubit/auth_cubit.dart';
import 'bloc/Auth_Cubit/auth_state.dart';
import 'bloc/Login_Cubit/login_cubit.dart';
import 'bloc/Profile_Cubit/profile_cubit.dart';
import 'bloc/Profile_Cubit/profile_state.dart';
import 'bloc/ProfileEdit_Cubit/profile_edit_cubit.dart';
import 'firebase_service/firebase_options.dart';

import 'screens/auth_screen.dart';
import 'screens/guest_conversion_screen.dart';
import 'screens/navigation_screen.dart';
import 'screens/profile_setup_screen.dart';
import 'screens/splash_screen.dart';
import 'themes/firefly_theme.dart';

// Simple BLoC observer for debugging
class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  // Add a short delay to ensure Firebase is fully initialized
  await Future.delayed(const Duration(milliseconds: 500));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Set up BLoC observer for debugging
  Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // Helper method to determine which screen to show based on auth and profile state
  Widget _getHomeScreen(AuthAuthenticated authState, ProfileState profileState) {
    // If profile is loading or initial, show splash screen
    if (profileState is ProfileLoading || profileState is ProfileInitial) {
      return const SplashScreen();
    }
    
    // If profile is incomplete, show profile setup screen
    if (profileState is ProfileIncomplete) {
      return const ProfileSetupScreen();
    }
    
    // If there's an error with the profile, still allow navigation but will prompt later
    if (profileState is ProfileError) {
      print('Profile error: ${profileState.message}');
      return const NavigationScreen();
    }
    
    // If profile is loaded or any other state, show navigation screen
    return const NavigationScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
          lazy: false, // Create immediately instead of on first access
        ),
        BlocProvider(
          create: (context) => CharacterBloc(),
        ),
        BlocProvider<FavoritesCubit>(
          create: (context) => FavoritesCubit(),
          lazy: false, // Create immediately to listen for auth changes
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
          lazy: false, // Create immediately to listen for auth changes
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileEditCubit(),
        ),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            print('Auth error in main.dart: ${state.message}');
          }
          
          // Update favorites when auth state changes
          if (state is AuthAuthenticated) {
            // User logged in, load their favorites
            context.read<FavoritesCubit>().onUserChanged(state.user);
            // Update profile state
            context.read<ProfileCubit>().onUserChanged(state.user);
          } else if (state is AuthUnauthenticated) {
            // User logged out, clear favorites
            context.read<FavoritesCubit>().onUserChanged(null);
            // Update profile state
            context.read<ProfileCubit>().onUserChanged(null);
          }
        },
        builder: (context, authState) {
          print('Current auth state in main.dart: $authState');
          
          // If user is authenticated, check if profile is complete
          if (authState is AuthAuthenticated) {
            return BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, profileState) {
                return MaterialApp(
                  title: 'HSR Stats Calculator',
                  theme: FireflyTheme.theme,
                  debugShowCheckedModeBanner: false,
                  home: _getHomeScreen(authState, profileState),
                  routes: {
                    '/auth': (context) => const AuthScreen(),
                    '/navigation': (context) => const NavigationScreen(),
                    '/profile_setup': (context) => const ProfileSetupScreen(),
                    '/guest_conversion': (context) => const GuestConversionScreen(),
                    '/splash': (context) => const SplashScreen(),
                  },
                );
              },
            );
          }
          
          // If user is not authenticated, check if we're still initializing
          if (authState is AuthInitial || authState is AuthLoading) {
            return MaterialApp(
              title: 'HSR Stats Calculator',
              theme: FireflyTheme.theme,
              debugShowCheckedModeBanner: false,
              home: const SplashScreen(),
            );
          }
          
          // Otherwise, show auth screen
          return MaterialApp(
            title: 'HSR Stats Calculator',
            theme: FireflyTheme.theme,
            debugShowCheckedModeBanner: false,
            home: const AuthScreen(),
            routes: {
              '/auth': (context) => const AuthScreen(),
              '/navigation': (context) => const NavigationScreen(),
              '/profile_setup': (context) => const ProfileSetupScreen(),
              '/guest_conversion': (context) => const GuestConversionScreen(),
              '/splash': (context) => const SplashScreen(),
            },
          );
        },
      ),
    );
  }
}

