import 'package:hungry/core/utils/exported_file.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.quantity,
    this.preRequest,
  });

  final String imageUrl, title;
  final int quantity;

  final Function()? preRequest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(imageUrl, width: 100),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(20),
                      CustomText(text: title, fontWeight: FontWeight.bold),
                      CustomText(text: 'quantity : X3'),
                      CustomText(text: 'price : \$8'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: GestureDetector(
                onTap: preRequest,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: CustomText(text: 'Order Again', color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
