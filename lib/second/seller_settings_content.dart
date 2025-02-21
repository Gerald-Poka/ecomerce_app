import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/providers/theme_provider.dart';

class SellerSettingsContent extends StatelessWidget {
  const SellerSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Dark Mode Toggle
        ListTile(
          title: const Text('Dark Mode'),
          trailing: Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return Switch(
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              );
            },
          ),
        ),

        // About Application
        ListTile(
          title: const Text('About Application'),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('About Application'),
                  content: const Text(
                    'This e-commerce application is designed to provide a seamless and secure shopping experience using blockchain technology. It supports both buyers and sellers, ensuring transparency and trust in every transaction.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          },
        ),

        // Appreciation Section
        ListTile(
          title: const Text('Appreciation'),
          subtitle: const Text('Honoring those who made this possible'),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Appreciation'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'We would like to extend our heartfelt gratitude to the following individuals for their invaluable support and contributions:',
                      ),
                      SizedBox(height: 10),
                      Text(
                        '👤 Mtu Mzuri (FYP Group Supervisor),\n👤 Fredrick Kamugisha(former Student),\n👤 Gerald Ndyamukama (former Student)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Your guidance, ideas, and encouragement have been instrumental in the development of this application. Thank you!',
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
