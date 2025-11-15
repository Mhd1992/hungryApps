import 'package:hungry/core/utils/exported_file.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/features/cart/provider/cart_provider.dart';
import 'package:hungry/features/checkout/view/riverpod/checkout_view.dart';
import 'package:hungry/gen/assets.gen.dart';

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
      loadCartItems(ref: ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    final removeLoading = ref.watch(removeLoadingProvider);
    // final itemQty = ref.watch(quantityProvider);
    final quantities = ref.watch(quantitiesProvider);

    BuildContext mainContext = context;
    return (removeLoading)
        ? Center(child: CupertinoActivityIndicator())
        : Scaffold(
            body: cartState.when(
              data: (cart) {
                if (cart == null || cart.items.isEmpty) {
                  return Center(
                    child: Assets.icons.emptyIcon.image(
                      width: 200,
                      height: 200,
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Gap(32),
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
                              quantity: quantities[index],
                              onChanged: (newValue) {
                                setState(() {
                                  cart.items[index] = cart.items[index]
                                      .copyWith(
                                        quantity:
                                            ref
                                                    .read(
                                                      quantitiesProvider
                                                          .notifier,
                                                    )
                                                    .state[index] =
                                                newValue,
                                      );

                                  ref
                                          .read(quantitiesProvider.notifier)
                                          .state[index] =
                                      newValue;
                                });
                              },
                              onRemove: () async {
                                final message = await removeItem(
                                  ref: ref,
                                  itemId: item.itemId,
                                );
                                showMessage(
                                  message ?? 'Item removed',
                                  // ignore: use_build_context_synchronously
                                  mainContext,
                                  isError: message?.contains('Failed') == true,
                                );
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
                child: CupertinoActivityIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          );
  }
}
