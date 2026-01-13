import 'package:flutter/material.dart';
import 'package:hungry/core/constants/app_colors.dart';

import 'package:hungry/update_features/home/categories/data/category_model.dart';

class CustomWrapFilterChoice extends StatelessWidget {
  const CustomWrapFilterChoice({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onChanged,
  });

  // final List<String> categories;
  final List<CategoryModel> categories;

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 16.0, // Space between chips
        children: List.generate(categories.length, (index) {
          return FilterChip(
            mouseCursor: MouseCursor.uncontrolled,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(50.0),
            ),
            label: Text(
              categories[index].name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: selectedIndex == index
                    ? Colors.white
                    : Colors.grey.shade900,
              ),
            ),
            selected: selectedIndex == index,
            selectedColor: AppColors.primaryColor,
            backgroundColor: Color(0xffF3F4F6),
            checkmarkColor: Colors.white,
            onSelected: (bool selected) {
              onChanged(index);
            },
          );
        }),
      ),
    );
  }
}
