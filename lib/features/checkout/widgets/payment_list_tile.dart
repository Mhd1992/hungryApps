import 'package:hungry/core/utils/exported_file.dart';

class PaymentListTile extends StatelessWidget {
  const PaymentListTile({
    super.key,
    required this.paymentLogo,
    required this.text,
  });
  final String paymentLogo;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Color(0xff3C2F2F),
      title: CustomText(text: text, color: Colors.white),
      leading: Image.asset(paymentLogo, width: 50),
      trailing: Radio<String>(
        activeColor: Colors.white,
        value: 'Cash',
        groupValue: 'Cash',
        onChanged: (val) {},
      ),
    );
  }
}
