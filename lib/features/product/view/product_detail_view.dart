import 'package:hungry/core/utils/exported_file.dart';

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
            ],
          ),
        ),
      ),
      bottomSheet: IntrinsicHeight(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade900,
                blurRadius: 20,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
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
          ),
        ),
      ),
    );
  }
}
