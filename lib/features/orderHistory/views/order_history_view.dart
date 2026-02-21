import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/utils/exported_file.dart';

import '../../../core/networks/error_widget.dart';
import '../../../update_features/checkout/order_history/controller/order_history_controller.dart';
import 'item_detail.dart';

class OrderHistoryView extends ConsumerStatefulWidget {
  const OrderHistoryView({super.key});

  @override
  ConsumerState<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends ConsumerState<OrderHistoryView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(orderHistoryControllerProvider.notifier).getOrders();

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthRepo authRepo = AuthRepo();
    final historyState = ref.watch(orderHistoryControllerProvider);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),

        child: (authRepo.isGuest)
            ? Center(child: GuestLogo())
            : historyState.when(
                data: (data) {
                  final orders = data ?? [];

                  return Column(
                    children: [
                      // Scrollable content
                      Expanded(
                        child: ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            final orders = data ?? [];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ItemDetail(orders[index].id),
                                  ),
                                );
                              },
                              child: HistoryCard(
                                imageUrl: orders[index].productImage,
                                title: orders[index].status.name,
                                quantity: orders[index].totalPrice,
                              ),
                            );
                          },
                        ),
                      ),

                      // Fixed bottom section
                    ],
                  );
                },
                error: (error, _) => AppErrorWidget(error: error),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }
}
