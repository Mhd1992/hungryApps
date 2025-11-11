import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/cart/provider/cartProvider.dart';
import 'package:hungry/gen/assets.gen.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartControllerProvider);
    final cartController = ref.read(cartControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: cartState.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, _) => Center(child: Text("Something went wrong")),

        data: (cartData) {
          if (cartData == null || cartData.items.isEmpty) {
            return Center(
              child: Assets.icons.emptyIcon.image(width: 200, height: 200),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  itemCount: cartData.items.length,
                  itemBuilder: (context, index) {
                    final item = cartData.items[index];
                    return CartItem(
                      title: item.name,
                      imageUrl: item.imageUrl,
                      desc: '',
                      quantity: item.quantity,
                      onChanged: (newQty) {
                        cartData.items[index] = item.copyWith(quantity: newQty);
                      },
                      onRemove: () {
                        cartController.removeCartItem(item.itemId);
                      },
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Price:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text("\$${cartData.totalPrice}"),
                      ],
                    ),
                    const Spacer(),
                    CustomButton(
                      buttonText: 'Checkout',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckOutView(
                              cartItemModel: cartData,
                              totalPrice: cartData.totalPrice,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

///    /// Start loading when widget builds
///    like initState and futureBuilder in statelessWidget
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       loadCartItem();
//     });
