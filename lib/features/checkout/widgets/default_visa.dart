import 'package:hungry/core/utils/exported_file.dart';

class DefaultVisa extends StatelessWidget {
  const DefaultVisa({
    super.key,
    required this.titleText,
    required this.subTitleText,
    required this.imageUrl,
  });

  final String titleText, subTitleText, imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.white,
      title: CustomText(text: titleText, color: Colors.grey.shade900),
      subtitle: CustomText(
        text: subTitleText,
        color: Colors.black,
        fontWeight: FontWeight.w200,
      ),
      leading: Image.asset(imageUrl, width: 50),
      trailing: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: CustomText(
          text: 'Default',
          color: Colors.grey.shade900,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
