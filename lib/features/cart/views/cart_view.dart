import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/networks/error_widget.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/cart/provider/cartProvider.dart';
import 'package:hungry/gen/assets.gen.dart';
import 'package:hungry/update_features/auth/controller/auth_controller.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return; // ✅ double safety
      ref.read(cartControllerProvider.notifier).loadCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartControllerProvider);
    final cartController = ref.read(cartControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ref.read(guestProvider.notifier).state
          ? GuestLogo()
          : cartState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => AppErrorWidget(error: error),
              data: (cartData) {
                if (cartData == null || cartData.items.isEmpty) {
                  return Center(
                    child: Assets.icons.emptyIcon.image(
                      width: 200,
                      height: 200,
                    ),
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
                              cartData.items[index] = item.copyWith(
                                quantity: newQty,
                              );
                            },
                            onRemove: () async {
                              await cartController
                                  .removeCartItem(item.itemId)
                                  .then((val) {
                                    cartData.items.remove(item);
                                    if (!context.mounted) return;
                                    context.showSnackBar(val.toString());
                                  });
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
