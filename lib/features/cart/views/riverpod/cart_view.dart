import 'package:hungry/core/data/repositories/cart/cart_repo_provider.dart';
import 'package:hungry/core/data/repositories/cart/cart_state.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/features/checkout/view/riverpod/checkout_view.dart';
import 'package:hungry/gen/assets.gen.dart';

import '../../../../core/data/repositories/cart/cart_provider.dart';

class NewCartView extends ConsumerStatefulWidget {
  const NewCartView({super.key});

  @override
  ConsumerState<NewCartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<NewCartView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final provider = ref.read(cartRepoProvider);
      provider.fetchCartItem(ref: ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final quantityItem = ref.watch(quantitiesProviderV1);
    final cartState = ref.watch(cartStateProvider);
    return Scaffold(
      body: cartState.when(
        data: (cart) {
          if (cart == null || cart.items.isEmpty) {
            return Center(
              child: Assets.icons.emptyIcon.image(width: 200, height: 200),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Gap(64),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 20, top: 20),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];

                      return CartItem(
                        title: item.name,
                        imageUrl: item.imageUrl,
                        desc: '',
                        quantity: quantityItem[index],
                        onChanged: (newValue) {
                          setState(() {
                            cart.items[index] = cart.items[index].copyWith(
                              quantity:
                                  ref
                                          .read(quantitiesProviderV1.notifier)
                                          .state[index] =
                                      newValue,
                            );

                            ref
                                    .read(quantitiesProviderV1.notifier)
                                    .state[index] =
                                newValue;
                          });
                        },
                        onRemove: () async {
                          ref
                              .read(cartRepoProvider)
                              .removeCartItem(item.itemId, ref: ref);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Total Price:',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            text: (cart != null && cart.items.isNotEmpty)
                                ? '\$${cart?.totalPrice}'
                                : '\$0.0',
                            fontSize: 16,
                          ),
                        ],
                      ),
                      const Spacer(),
                      CustomButton(
                        buttonText: 'Checkout',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return CheckOutViewV1(
                                  cartItemModel: cart,
                                  totalPrice: cart.totalPrice,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        ),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
