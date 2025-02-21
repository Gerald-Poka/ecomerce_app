import 'dart:async';
import 'package:flutter/material.dart';

class AdvertisementWidget extends StatefulWidget {
  const AdvertisementWidget({super.key});

  @override
  State<AdvertisementWidget> createState() => _AdvertisementWidgetState();
}

class _AdvertisementWidgetState extends State<AdvertisementWidget> {
  late final PageController _pageController;
  late final Timer _timer;

  int _currentPage = 0;
  final int _totalPages = 3; // Update this if you change itemCount

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Set up a timer to auto-scroll
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _totalPages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // Loop back to the first page
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _totalPages,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0B90B),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Advertisement ${index + 1}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
