// lib/second/seller_orders_screen.dart
import 'package:flutter/material.dart';

class SellerOrdersScreen extends StatelessWidget {
  const SellerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Seller Orders')),
      body: Center(
        child: Text('List of Orders'),
      ),
    );
  }
}