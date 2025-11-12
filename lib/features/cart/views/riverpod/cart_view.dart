import 'package:hungry/core/networks/retrofit/model/cart/request_cart/cart_item_model.dart';
import 'package:hungry/core/utils/exported_file.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/features/cart/provider/cart_provider.dart';

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
    final itemQty = ref.watch(quantityProvider);
    final quantities = ref.watch(quantitiesProvider);

    BuildContext mainContext = context;
    return (removeLoading)
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(title: const Text('My Cart')),
            body: cartState.when(
              data: (cart) {
                if (cart == null || cart.items.isEmpty) {
                  return const Center(child: Text("Cart is empty"));
                }

                return Column(
                  children: [
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
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          );
  }
}
