import 'package:flutter/material.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class CustomWrapFilterChoice extends StatefulWidget {
  const CustomWrapFilterChoice({super.key, required this.categories});

  final List<String> categories;

  @override
  State<CustomWrapFilterChoice> createState() => _CustomWrapFilterChoiceState();
}

class _CustomWrapFilterChoiceState extends State<CustomWrapFilterChoice> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 16.0, // Space between chips
        children: List.generate(widget.categories.length, (index) {
          return GestureDetector(
            onTap: () => setState(() {
              currentIndex = index;
            }),
            child: Container(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: currentIndex == index
                    ? AppColors.primaryColor
                    : Color(0xffF3F4F6),
              ),
              child: CustomText(
                text: widget.categories[index],
                fontWeight: FontWeight.w500,
                color: currentIndex == index
                    ? Colors.white
                    : Colors.grey.shade900,
              ),
            ),
          );
        }),
      ),
    );
  }
}
