import 'package:hungry/core/utils/exported_file.dart';

class ContainerFilterChoice extends StatelessWidget {
  const ContainerFilterChoice({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onChanged(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: isSelected
                    ? AppColors.primaryColor
                    : const Color(0xffF3F4F6),
              ),
              child: CustomText(
                text: categories[index],
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.grey.shade900,
              ),
            ),
          );
        }),
      ),
    );
  }
}
