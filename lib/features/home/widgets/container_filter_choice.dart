import 'package:flutter/material.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class ContainerFilterChoice extends StatefulWidget {
  const ContainerFilterChoice({
    super.key,
    required this.categories,
    this.onSelected,
  });
  final List<String> categories;
  final Function()? onSelected;

  @override
  State<ContainerFilterChoice> createState() => _ContainerFilterChoiceState();
}

class _ContainerFilterChoiceState extends State<ContainerFilterChoice> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.categories.length, (index) {
          return GestureDetector(
            onTap: () => widget.onSelected,
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
