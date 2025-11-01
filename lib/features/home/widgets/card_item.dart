import 'package:hungry/core/utils/exported_file.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.rate,
  });

  final String title, imageUrl, description, rate;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(imageUrl, fit: BoxFit.cover, width: 150)),
            Gap(10),
            CustomText(text: title, fontWeight: FontWeight.bold),
            CustomText(text: description),
            Row(
              children: [
                CustomText(text: '⭐️$rate'),
                Spacer(),
                Icon(CupertinoIcons.heart, color: AppColors.primaryColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
