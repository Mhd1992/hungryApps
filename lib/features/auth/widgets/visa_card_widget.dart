import 'package:flutter/material.dart';

class VisaCardWidget extends StatelessWidget {
  const VisaCardWidget({
    super.key,
    required this.titleText,
    required this.subTitleText,
  });

  final String titleText;
  final String subTitleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF2C2C2C), Color(0xFF3A3A3A), Color(0xFF2C2C2C)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      child: Row(
        children: [
          // Visa logo
          const Text(
            'VISA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(width: 16),

          // Card info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleText,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 6),
                Text(
                  subTitleText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),

          // Default badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: const [
                Text(
                  'Default',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.check_circle, size: 16, color: Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
