import 'package:hungry/core/utils/exported_file.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({
    super.key,
    required this.order,
    required this.taxes,
    required this.fees,
    this.duration,
  });

  final double order, taxes, fees;
  final String? duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        infoBar(text: 'Order', amount: order),
        Gap(10),
        infoBar(text: 'Taxes', amount: taxes),
        Gap(10),
        infoBar(text: 'Delivery fees', amount: fees),
        Gap(10),
        Divider(),
        Gap(10),
        infoBar(text: 'Total', amount: order + taxes + fees, isBold: true),
        Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'Estimated delivery time',
              fontWeight: FontWeight.w600,
            ),
            CustomText(text: '15-30 minute', fontWeight: FontWeight.w600),
          ],
        ),
      ],
    );
  }
}

Widget infoBar({String? text, double? amount, bool isBold = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        text: text.toString(),
        fontSize: 16,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        color: isBold ? Colors.black : Colors.grey.shade500,
      ),
      CustomText(
        text: '\$ ${amount!.toStringAsFixed(3)}',
        fontSize: 16,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        color: isBold ? Colors.black : Colors.grey.shade500,
      ),
    ],
  );
}
