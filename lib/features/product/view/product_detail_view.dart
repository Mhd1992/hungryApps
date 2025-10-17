import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/product/widgets/spicy_slider.dart';
import 'package:hungry/features/product/widgets/topping_card.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  double spicyLevel = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/detail.png', height: 250),
                  Gap(64),
                  SpicySlider(
                    value: spicyLevel,
                    onChanged: (value) {
                      setState(() => spicyLevel = value);
                    },
                  ),
                ],
              ),
              Gap(16),
              CustomText(text: 'Toppings', fontSize: 32),
              Gap(16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
                      child: ToppingCard(
                        imageUrl: 'assets/images/tomato.png',
                        title: 'Tomato',
                        onAdd: () {},
                      ),
                    ),
                  ),
                ),
              ),
              Gap(16),
              CustomText(text: 'Side Options', fontSize: 32),
              Gap(16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
                      child: ToppingCard(
                        imageUrl: 'assets/images/tomato.png',
                        title: 'Tomato',
                        onAdd: () {},
                      ),
                    ),
                  ),
                ),
              ),
              Gap(20),
              Row(
                children: [
                  Column(
                    children: [
                      CustomText(
                        text: 'Total Price:',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(text: ' \$12.99', fontSize: 16),
                    ],
                  ),
                  Spacer(),
                  CustomButton(buttonText: 'Add To Cart', onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
