import 'package:flutter/material.dart';
import '../themes/firefly_theme.dart';
import '../widgets/settings_widgets/settings_header.dart';
import '../widgets/common_widgets/back_button_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: FireflyTheme.backgroundGradient),
        child: SafeArea(
          child: Stack(
            children: [
              _buildSettingsContent(context),
              const BackButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const SettingsHeader(),
          const SizedBox(height: 40),
          // TODO: Add settings content here
          Expanded(
            child: Center(
              child: Text(
                'Settings Content',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: FireflyTheme.gold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}