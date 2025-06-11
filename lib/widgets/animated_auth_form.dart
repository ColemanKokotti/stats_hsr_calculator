import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Auth_Cubit/auth_cubit.dart';
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
    context.read<AuthCubit>().signInAsGuest();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
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
    );
  }
}