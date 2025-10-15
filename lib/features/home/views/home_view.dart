import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/logo_image.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> categories = [
    'All',
    'Combo',
    'Sliders',
    'Juice',
    'chickenBurger',
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Gap(75),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LogoImage(
                        color: ColorFilter.mode(
                          AppColors.primaryColor,
                          BlendMode.srcIn,
                        ),
                        height: 35,
                      ),

                      Gap(8),
                      CustomText(
                        text: 'Hello dear user',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                  Spacer(),
                  CircleAvatar(radius: 30),
                ],
              ),
              Gap(16),
              Material(
                elevation: 3,
                shadowColor: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: Icon(CupertinoIcons.search),
                  ),
                ),
              ),
              Gap(16),
              SingleChildScrollView(
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
                        categories[index],
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
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
