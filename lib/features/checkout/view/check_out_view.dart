import 'package:hungry/core/utils/exported_file.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<PaymentType?> paymentMethod =
        ValueNotifier<PaymentType?>(PaymentType.cash);
    final ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: ValueListenableBuilder(
        valueListenable: paymentMethod,
        builder: (context, selectedMethod, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Order summary',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                const OrderDetail(order: '9.4', taxes: '0.7', fees: '1.4'),
                const Gap(80),
                const CustomText(
                  text: 'Payment methods',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                const Gap(20),

                PaymentListTile(
                  paymentLogo: 'assets/icons/cash.png',
                  text: 'Cash on Delivery',
                  value: PaymentType.cash,
                  groupValue: selectedMethod,
                  onChanged: (newVal) => paymentMethod.value = PaymentType.cash,
                ),
                const Gap(20),

                VisaListTile(
                  paymentLogo: 'assets/icons/visaSvg.svg',
                  text: 'Debit Card',
                  subTitleText: '3566 **** **** 0505',
                  value: PaymentType.visa,
                  groupValue: selectedMethod,
                  onChanged: (newVal) => paymentMethod.value = PaymentType.visa,
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
              ],
            ),
          );
        },
      ),

      // ✅ Bottom sheet automatically fits content
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
      ),
    );
  }
}

enum PaymentType { cash, visa }
