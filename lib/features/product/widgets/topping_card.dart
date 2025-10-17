import 'package:flutter/material.dart';

class ToppingCard extends StatelessWidget {
  const ToppingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onAdd,
  });

  final String imageUrl;
  final String title;
  final VoidCallback onAdd;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(imageUrl, height: 80, fit: BoxFit.cover),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF3A2E2E),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.red,
                  child: GestureDetector(
                    onTap: onAdd,
                    child: Icon(Icons.add, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
