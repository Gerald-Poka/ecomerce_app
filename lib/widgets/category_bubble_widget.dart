import 'package:flutter/material.dart';

class CategoryBubbleWidget extends StatelessWidget {
  const CategoryBubbleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // ignore: deprecated_member_use
              color: const Color(0xFFF0B90B).withOpacity(0.2),
            ),
            child: Center(
              child: Text('Category ${index + 1}'),
            ),
          );
        },
      ),
    );
  }
}

