import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/providers/theme_provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Switch(
          value: themeProvider.themeMode == ThemeMode.dark,
          onChanged: (value) {
            themeProvider.toggleTheme(value);
          },
        );
      },
    );
  }
}
