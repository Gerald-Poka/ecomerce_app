import 'package:ecommerce_app/screens/chatbot_screen.dart';
import 'package:ecommerce_app/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/widgets/advertisement_widget.dart';
import 'package:ecommerce_app/widgets/category_bubble_widget.dart';
import 'package:ecommerce_app/widgets/product_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            AdvertisementWidget(),
            CategoryBubbleWidget(),
            ProductListWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // Set the currently active index
        selectedItemColor: const Color(0xFFF0B90B),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatbotScreen()),
            );
          }
          if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          }
        },
        items: List.generate(5, (index) {
          final isActive = index == 0; // Assuming currentIndex = 0 for now
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
