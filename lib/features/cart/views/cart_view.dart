import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/networks/error_widget.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/gen/assets.gen.dart';
import 'package:hungry/update_features/auth/controller/auth_controller.dart';
import 'package:riverpod/src/framework.dart';

import '../../../update_features/cart/controller/cart_action_controller.dart';
import '../../../update_features/cart/controller/cart_controller.dart';
import '../../../update_features/cart/controller/cart_screen_contoller.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  @override
  void initState() {
    super.initState();
    ref.listenManual<AsyncValue<String?>>(cartActionControllerProvider, (
      prev,
      next,
    ) {
      next.whenOrNull(
        data: (data) {
          if (data != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.orange,

                content: SizedBox(
                  height: 48,
                  child: Center(
                    child: Text(
                      data,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            );
          }
        },
        loading: () => CircularProgressIndicator(),
      );
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      ref.read(cartControllerProvider.notifier).loadCartItem();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartControllerProvider);
    final screenState = ref.watch(cartScreenProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ref.read(guestProvider.notifier).state
          ? GuestLogo()
          : screenState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => AppErrorWidget(error: error),
              data: (cartData) {
                if (cartData == null) {
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
                        itemCount: cartData.cartItemModel!.items.length,
                        itemBuilder: (context, index) {
                          final item = cartData.cartItemModel!.items[index];
                          return CartItem(
                            title: item.name,
                            imageUrl: item.imageUrl,
                            desc: '',
                            quantity: item.quantity,
                            onChanged: (newQty) {
                              cartData.cartItemModel!.items[index] = item
                                  .copyWith(quantity: newQty);
                              setState(() {});
                            },
                            onRemove: () async {
                              await ref
                                  .read(cartActionControllerProvider.notifier)
                                  .removeFromCartItem(item.itemId);
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
                              Text("\$${cartData.cartItemModel!.totalPrice}"),
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
                                    cartItemModel: cartData.cartItemModel!,
                                    totalPrice:
                                        cartData.cartItemModel!.totalPrice,
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
