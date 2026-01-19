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

      ref.read(cartControllerProvider.notifier).loadCartItem(useCache: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartControllerProvider);
    final actionState = ref.watch(cartActionControllerProvider);
    final isRemoving = actionState is AsyncLoading && actionState.value == null;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ref.read(guestProvider.notifier).state
          ? GuestLogo()
          : isRemoving
          ? Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            )
          : cartState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => AppErrorWidget(error: error),
              data: (cartData) {
                if (cartData == null) {
                  return const Center(child: Text('No cart data'));
                }

                if (cartData.items.isEmpty) {
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
