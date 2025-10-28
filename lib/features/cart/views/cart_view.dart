import 'package:hungry/core/utils/exported_file.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ValueNotifier<int>> quantities = List.generate(
      3,
      (_) => ValueNotifier<int>(0),
    );
    final ValueNotifier<int> initialValue = ValueNotifier<int>(0);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Scrollable content
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 20, top: 20),
                itemCount: quantities.length,
                itemBuilder: (context, index) {
                  return ValueListenableBuilder<int>(
                    valueListenable: quantities[index],
                    builder: (context, value, _) {
                      return CartItem(
                        title: 'Hamburger',
                        imageUrl: 'assets/images/test.png',
                        desc: 'Veggie Burger',
                        quantity: quantities[index].value,
                        onChanged: (newValue) {
                          quantities[index].value = newValue;
                        },
                      );
                    },
                  );
                },
              ),
            ),

            // Fixed bottom section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CustomText(
                        text: 'Total Price:',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(text: '\$12.99', fontSize: 16),
                    ],
                  ),
                  const Spacer(),
                  CustomButton(
                    buttonText: 'Checkout',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return CheckOutView();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      /*    bottomSheet: IntrinsicHeight(
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
                color: Colors.grey.shade800,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // 👈 important!
                  children: const [
                    CustomText(
                      text: 'Total Price:',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(text: '\$11.15', fontSize: 16),
                  ],
                ),
                const Spacer(),
                CustomButton(
                  buttonText: 'Pay Now',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SuccessDialog(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),*/
    );
  }
}
