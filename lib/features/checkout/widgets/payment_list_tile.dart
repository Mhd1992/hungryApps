import 'package:hungry/core/utils/exported_file.dart';

class PaymentListTile extends StatelessWidget {
  const PaymentListTile({
    super.key,
    required this.paymentLogo,
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String paymentLogo;
  final String text;
  final PaymentType value;
  final PaymentType? groupValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: const Color(0xff3C2F2F),
      title: CustomText(text: text, color: Colors.white),
      leading: Image.asset(paymentLogo, width: 50),
      trailing: Radio<String>(
        activeColor: Colors.white,
        value: value.name,
        groupValue: groupValue!.name,
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
      ),
      onTap: () => onChanged(value.name),
    );
  }
}
