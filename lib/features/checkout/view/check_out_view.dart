import 'package:hungry/core/utils/exported_file.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> paymentMethod = ValueNotifier<String>('cash');
    final ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ValueListenableBuilder(
          valueListenable: paymentMethod,
          builder: (context, selectedMethod, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Order summary',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                const OrderDetail(order: '9.4', taxes: '0.7', fees: '1.4'),
                const Gap(40),
                const CustomText(
                  text: 'Payment methods',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                const Gap(20),

                // Cash Tile
                PaymentListTile(
                  paymentLogo: 'assets/icons/cash.png',
                  text: 'Cash on Delivery',
                  value: 'cash',
                  groupValue: selectedMethod,
                  onChanged: (newVal) => paymentMethod.value = newVal,
                ),

                const Gap(20),

                // Visa Tile
                VisaListTile(
                  paymentLogo: 'assets/icons/visaSvg.svg',
                  text: 'Debit Card',
                  subTitleText: '3566 **** **** 0505',
                  value: 'visa',
                  groupValue: selectedMethod,
                  onChanged: (newVal) => paymentMethod.value = newVal,
                ),

                const Gap(20),

                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: isChecked,
                      builder: (context, value, _) => Checkbox(
                        value: isChecked.value,
                        onChanged: (val) => isChecked.value = val!,
                        activeColor: AppColors.primaryColor,
                      ),
                    ),
                    const CustomText(
                      text: 'Save card details for future payments',
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 32.0,
                  ),
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
                          CustomText(text: '\$11.15', fontSize: 16),
                        ],
                      ),
                      const Spacer(),
                      CustomButton(buttonText: 'Pay Now', onPressed: () {}),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
