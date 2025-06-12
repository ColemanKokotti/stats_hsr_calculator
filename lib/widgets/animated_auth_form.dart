import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Auth_Cubit/auth_cubit.dart';
import '../../bloc/Auth_Cubit/auth_state.dart';
import '../bloc/Auth_Screen_Cubit/auth_screen_cubit.dart';
import 'auth_screen_widget/login_widgets/login_widget.dart';
import 'auth_screen_widget/registration_widgets/registration_widget.dart';

class AnimatedAuthForm extends StatefulWidget {
  final bool isLogin;

  const AnimatedAuthForm({
    super.key,
    required this.isLogin,
  });

  @override
  State<AnimatedAuthForm> createState() => _AnimatedAuthFormState();
}

class _AnimatedAuthFormState extends State<AnimatedAuthForm>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleAuthMode() {
    context.read<AuthScreenCubit>().toggleAuthMode();
  }

  void _handleGuestLogin() {
    // Print debug message before guest login
    print('Attempting guest login');
    
    // Show loading indicator
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logging in as guest...'),
        duration: Duration(seconds: 1),
      ),
    );
    
    // Sign in as guest
    context.read<AuthCubit>().signInAsGuest();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // Debug print to track auth state changes
        print('Auth state in AnimatedAuthForm: $state');
      },
      child: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - _fadeAnimation.value)),
              child: widget.isLogin
                  ? LoginWidget(
                onSwitchToRegister: _toggleAuthMode,
                onGuestLogin: _handleGuestLogin,
              )
                  : RegisterWidget(
                onSwitchToLogin: _toggleAuthMode,
              ),
            ),
          );
        },
      ),
    );
  }
}