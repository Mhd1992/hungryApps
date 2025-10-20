import 'package:hungry/core/utils/exported_file.dart';

class VisaListTile extends StatelessWidget {
  const VisaListTile({
    super.key,
    required this.paymentLogo,
    required this.text,
    required this.subTitleText,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String paymentLogo;
  final String text;
  final String subTitleText;
  final PaymentType value;
  final PaymentType? groupValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.blue.shade900,
      title: CustomText(text: text, color: Colors.white),
      subtitle: CustomText(
        text: subTitleText,
        color: Colors.white,
        fontWeight: FontWeight.w200,
      ),
      leading: SvgPicture.asset(
        paymentLogo,
        width: 50,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
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
