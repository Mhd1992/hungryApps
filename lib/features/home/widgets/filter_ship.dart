import 'package:flutter/material.dart';
import 'package:hungry/core/constants/app_colors.dart';

class FilterShip extends StatefulWidget {
  const FilterShip({super.key, required this.categories});
  final List<String> categories;
  @override
  State<FilterShip> createState() => _FilterShipState();
}

class _FilterShipState extends State<FilterShip> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.categories.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),

            child: FilterChip(
              mouseCursor: MouseCursor.uncontrolled,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(50.0),
              ),
              label: Text(
                widget.categories[index],
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: currentIndex == index
                      ? Colors.white
                      : Colors.grey.shade900,
                ),
              ),
              selected: currentIndex == index,
              selectedColor: AppColors.primaryColor,
              backgroundColor: Color(0xffF3F4F6),

              onSelected: (bool selected) {
                setState(() {
                  currentIndex = index;

                  /// Deselect if tapped again   currentIndex = selected ? index : -1;
                });
              },
            ),
          );
        }),
      ),
    );
  }
}
