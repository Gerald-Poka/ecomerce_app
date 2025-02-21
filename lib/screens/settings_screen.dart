import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/providers/theme_provider.dart';
import 'package:ecommerce_app/screens/chatbot_screen.dart';
import 'package:ecommerce_app/screens/home_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 4, // Set the active index for Settings
        selectedItemColor: const Color(0xFFF0B90B),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
          if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ChatbotScreen()),
            );
          }
        },
        items: List.generate(5, (index) {
          final isActive = index == 4; // Active index for Settings
          return BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: isActive ? 50 : 40,
              width: isActive ? 50 : 40,
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFFF0B90B).withAlpha(51)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForIndex(index),
                color: isActive ? const Color(0xFFF0B90B) : Colors.grey,
                size: isActive ? 28 : 24,
              ),
            ),
            label: _getLabelForIndex(index),
          );
        }),
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.history;
      case 2:
        return Icons.person;
      case 3:
        return Icons.chat;
      case 4:
        return Icons.settings;
      default:
        return Icons.home;
    }
  }

  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'History';
      case 2:
        return 'Profile';
      case 3:
        return 'Chatbot';
      case 4:
        return 'Settings';
      default:
        return '';
    }
  }
}
