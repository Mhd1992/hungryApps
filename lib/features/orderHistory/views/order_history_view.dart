import 'package:hungry/core/utils/exported_file.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Scrollable content
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return HistoryCard(
                    imageUrl: 'assets/images/test.png',
                    title: 'Veggie Burger',
                    quantity: 3,
                  );
                },
              ),
            ),

            // Fixed bottom section
          ],
        ),
      ),
    );
  }
}
