import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/images/detail.png', height: 250),
                Gap(64),
                Expanded(
                  child: Column(
                    children: [
                      CustomText(
                        text:
                            'Customize Your Burger to Your Tastes. Ultimate Experience',
                        fontWeight: FontWeight.w500,
                      ),
                      Slider(
                        padding: EdgeInsets.zero,
                        min: 0,
                        max: 1,
                        value: 0.75,
                        activeColor: AppColors.primaryColor,
                        inactiveColor: Colors.grey,
                        onChanged: (val) {},
                      ),
                      Row(children: [Text('🥶'), Spacer(), Text('🌶️')]),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
