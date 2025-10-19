import 'package:hungry/core/utils/exported_file.dart';

class VisaListTile extends StatelessWidget {
  const VisaListTile({
    super.key,
    required this.paymentLogo,
    required this.text,
    required this.subTitleText,
  });
  final String paymentLogo;
  final String text, subTitleText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Color(0xffF3F4F6),
      title: CustomText(text: text, color: Colors.black),
      subtitle: CustomText(
        text: subTitleText,
        color: Colors.black,
        fontWeight: FontWeight.w200,
      ),
      leading: Image.asset(paymentLogo, width: 50),
      trailing: Radio<String>(
        activeColor: Colors.black,
        value: 'visa',
        groupValue: 'visa',
        onChanged: (val) {},
      ),
    );
  }
}
