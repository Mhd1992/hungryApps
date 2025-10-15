import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

import '../../../shared/logo_image.dart';
import 'card_item.dart';
import 'custom_filter_wrap_choice.dart';

class PrimitiveGridView extends StatefulWidget {
  const PrimitiveGridView({super.key});

  @override
  State<PrimitiveGridView> createState() => _PrimitiveGridViewState();
}

class _PrimitiveGridViewState extends State<PrimitiveGridView> {
  @override
  Widget build(BuildContext context) {
    int _selectedCategoryIndex = 0;
    List<String> categories = [
      'All',
      'Combo',
      'Sliders',
      'Juice',
      'chickenBurger',
    ];
    int currentIndex = 0;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
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
                    fillColor: Colors.white,
                    filled: true,
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

              CustomWrapFilterChoice(
                categories: categories,
                selectedIndex: _selectedCategoryIndex,
                onChanged: (newIndex) {
                  setState(() {
                    _selectedCategoryIndex = newIndex;
                  });
                },
              ),
              Gap(8),

              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return CardItem(
                    title: 'CheeseBurger',
                    imageUrl: 'assets/images/test.png',
                    description: 'Happy Burger',
                    rate: '️3.8',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
