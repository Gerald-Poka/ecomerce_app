import 'package:ecommerce_app/second/seller_chart_screen.dart';
import 'package:ecommerce_app/second/seller_settings_content.dart';
import 'package:flutter/material.dart';
// import '../screens/settings_screen.dart';

class SellerHomeScreen extends StatefulWidget {
  const SellerHomeScreen({super.key});

  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: _buildMainContent(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFF0B90B),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.inventory, 'Products', 1),
          _buildNavItem(Icons.shopping_bag, 'Orders', 2),
          _buildNavItem(Icons.person, 'Profile', 3),
          _buildNavItem(Icons.settings, 'Settings', 4),
        ],
      ),
      floatingActionButton: _selectedIndex == 1 
          ? FloatingActionButton(
              onPressed: () {
                // Add new product
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    final isActive = index == _selectedIndex;
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: isActive ? 50 : 40,
        width: isActive ? 50 : 40,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF0B90B).withAlpha(51) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isActive ? const Color(0xFFF0B90B) : Colors.grey,
          size: isActive ? 28 : 24,
        ),
      ),
      label: label,
    );
  }

  Widget _buildMainContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildProducts();
      case 2:
        return _buildOrders();
      case 3:
        return _buildProfile();
      case 4:
        return const SellerSettingsContent();
      default:
        return const Center(child: Text('Page not found'));
    }
  }

// In your _buildDashboard() method:
Widget _buildDashboard() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Analytics Chart
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: const SellerChartScreen(),
        ),
        
        const SizedBox(height: 24),
        
        // Statistics Cards
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildStatsCard(
              'Total Sales', 
              '₹50,000', 
              Icons.monetization_on,
              const Color(0xFF4CAF50),
            ),
            _buildStatsCard(
              'Orders', 
              '25', 
              Icons.shopping_cart,
              const Color(0xFF2196F3),
            ),
            _buildStatsCard(
              'Customers', 
              '120', 
              Icons.people,
              const Color(0xFFF44336),
            ),
            _buildStatsCard(
              'Products', 
              '45', 
              Icons.inventory,
              const Color(0xFFFF9800),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildStatsCard(String title, String value, IconData icon, Color color) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon, 
            size: 48, 
            color: color,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildProducts() {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              color: Colors.grey[200],
              child: const Icon(Icons.image),
            ),
            title: Text('Product ${index + 1}'),
            subtitle: Text('₹${(index + 1) * 100}'),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
              onSelected: (value) {
                // Handle menu item selection
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrders() {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            title: Text('Order #${1000 + index}'),
            subtitle: Text('Customer: Customer ${index + 1}'),
            trailing: Chip(
              label: Text(
                index % 2 == 0 ? 'Pending' : 'Delivered',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: index % 2 == 0 ? Colors.orange : Colors.green,
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfile() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: 16),
          const Text(
            'Seller Name',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('seller@example.com'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Handle edit profile
            },
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}
