import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/cart/data/repository/cart_repository.dart';
import 'package:hungry/shared/extensions/ref_extension.dart';
import 'package:hungry/update_features/cart/cart/request_cart/cart_item_model.dart';
import 'package:hungry/update_features/cart/controller/cart_controller.dart';
import 'package:hungry/update_features/products/product_details/product_detail_controller.dart';
import 'package:hungry/update_features/products/product_details/side_option/controller/side_option_controller.dart';
import 'package:hungry/update_features/products/product_details/topping/controller/topping_controller.dart';

import 'package:hungry/update_features/cart/cart/items/item_model.dart'
    as cart_request;
import '../../../../core/networks/error_widget.dart';
import '../../widgets/spicy_slider.dart';
import '../../widgets/topping_card.dart';

class ProductDetailView extends ConsumerStatefulWidget {
  const ProductDetailView({
    super.key,
    required this.productId,
    required this.price,
  });

  final int productId;
  final String price;

  @override
  ConsumerState<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends ConsumerState<ProductDetailView> {
  List<ToppingModel> toppings = [];
  List<SideOptionModel> options = [];
  Set<int> selectedToppings = {};
  Set<int> selectedOptions = {};
  double spicyLevel = 0.5;
  //ProductOptionRepo productOptionRepo = ProductOptionRepo();

  List<CartModel> cartModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(toppingControllerProvider.notifier).loadToppings();
      ref.read(sideOptionControllerProvider.notifier).loadSideOption();
      setState(() {});
    });

    ref.listenManual<AsyncValue<CartItemModel?>>(cartControllerProvider, (
      previous,
      next,
    ) {
      next.whenOrNull(
        data: (state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('cart added successfully'),
              backgroundColor: Colors.orange,
            ),
          );
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productDetailScreenProvider);
    return PopScope(
      // canPop: false,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white),
        body: state.when(
          data: (data) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/detail.png', height: 250),
                      Gap(64),
                      SpicySlider(
                        value: spicyLevel,
                        onChanged: (value) {
                          setState(() => spicyLevel = value);
                        },
                      ),
                    ],
                  ),

                  Gap(16),
                  CustomText(text: 'Toppings', fontSize: 32),
                  Gap(16),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        data.toppings.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(
                            right: 16.0,
                            bottom: 16.0,
                          ),
                          child: ToppingCard(
                            imageUrl: data.toppings[index].imageUrl,
                            title: data.toppings[index].name,
                            isSelected: selectedToppings.contains(
                              data.toppings[index].id,
                            ),
                            onAdd: () {
                              setState(() {
                                if (selectedToppings.contains(
                                  data.toppings[index].id,
                                )) {
                                  selectedToppings.remove(
                                    data.toppings[index].id,
                                  ); // remove if exists
                                } else {
                                  selectedToppings.add(
                                    data.toppings[index].id,
                                  ); // add if not
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(16),
                  CustomText(text: 'Side Options', fontSize: 32),
                  Gap(16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        data.sideOptions.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(
                            right: 16.0,
                            bottom: 16.0,
                          ),
                          child: ToppingCard(
                            imageUrl: data.sideOptions[index].imageUrl,
                            title: data.sideOptions[index].name,
                            isSelected: selectedOptions.contains(
                              data.sideOptions[index].id,
                            ),
                            onAdd: () {
                              setState(() {
                                if (selectedOptions.contains(
                                  data.sideOptions[index].id,
                                )) {
                                  selectedOptions.remove(
                                    data.sideOptions[index].id,
                                  ); // remove if exists
                                } else {
                                  selectedOptions.add(
                                    data.sideOptions[index].id,
                                  ); // add if not
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(20),
                ],
              ),
            ),
          ),
          error: (error, _) => AppErrorWidget(error: error),
          loading: () => Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
        ),

        bottomSheet: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final controller = ref.watch(cartControllerProvider);
            return controller.when(
              data: (_) => IntrinsicHeight(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade900,
                        blurRadius: 20,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            CustomText(
                              text: 'Total Price:',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            state.isLoading
                                ? Text('0')
                                : CustomText(
                                    text: '\$${widget.price}',
                                    fontSize: 16,
                                  ),
                          ],
                        ),
                        Spacer(),
                        CustomButton(
                          buttonText: 'Add To Cart',
                          onPressed: () {
                            // addToCart();

                            ///to reset cached
                            //  cartRepo.
                            //   if (cartRepo.cachedCartItem != null) {}

                            cartModel.add(
                              CartModel(
                                widget.productId,
                                1,
                                spicyLevel,
                                selectedToppings.toList(),
                                selectedOptions.toList(),
                              ),
                            );
                            ref
                                .read(cartControllerProvider.notifier)
                                .addToCartItem(
                                  cart_request.CartRequest(cartModel),
                                );
                            //   addCartX();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              error: (error, _) => AppErrorWidget(error: error),
              loading: () =>
                  CircularProgressIndicator(color: AppColors.primaryColor),
            );
          },
        ),
      ),
    );
  }
}
