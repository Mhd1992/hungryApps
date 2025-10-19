import 'package:hungry/core/utils/exported_file.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Order summary',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            OrderDetail(order: '9.4', taxes: '0.7', fees: '1.4'),
            Gap(40),
            CustomText(
              text: 'Payment methods ',
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            Gap(20),
            PaymentListTile(
              paymentLogo: 'assets/icons/cash.png',
              text: 'Cash on Delivery',
            ),
            Gap(20),
            VisaListTile(
              paymentLogo: 'assets/icons/visa.png',
              text: 'Debit Card',
              subTitleText: '3566 **** **** 0505',
            ),
            Gap(20),
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (val) {},
                  activeColor: AppColors.primaryColor,
                ),
                CustomText(text: 'Save card details for future payments'),
              ],
            ),
            Spacer(),
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
        ),
      ),
    );
  }
}
