import 'package:hungry/core/data/repositories/cart/cart_provider.dart';
import 'package:hungry/core/data/repositories/cart/cart_repo_provider.dart';
import 'package:hungry/core/data/repositories/products/side_options/side_options_provider.dart';
import 'package:hungry/core/data/repositories/products/toppings/toppings_provider.dart';
import 'package:hungry/core/networks/retrofit/model/cart/items/item_model.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/cart/data/repository/cart_repository.dart';

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
  double spicyLevel = 0.5;

  CartRepo cartRepo = CartRepo();
  List<CartModel> cartModel = [];
  bool _isAdded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final sideOptionController = ref.read(
        sideOptionControllerProvider.notifier,
      );
      sideOptionController.handleData(
        () => ref.read(sideOptionProvider).fetchSideOption(ref: ref),
      );

      final toppingController = ref.read(toppingControllerProvider.notifier);
      toppingController.handleData(
        () => ref.read(toppingProvider).fetchTopping(ref: ref),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final toppingState = ref.watch(sideOptionControllerProvider);
    final optionState = ref.watch(toppingControllerProvider);
    final loadProvider = ref.watch(loading);
    final selectedOption = ref.watch(selectedOptionProvider);
    final selectedTopping = ref.watch(selectedToppingProvider);

    final isLoading = toppingState.isLoading || optionState.isLoading;
    return PopScope(
      // canPop: false,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              )
            : Padding(
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
                      toppingState.when(
                        data: (toppings) => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              toppings!.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(
                                  right: 16.0,
                                  bottom: 16.0,
                                ),
                                child: ToppingCard(
                                  imageUrl: toppings[index].imageUrl,
                                  title: toppings[index].name,
                                  isSelected: selectedTopping.contains(
                                    toppings[index].id,
                                  ),
                                  onAdd: () {
                                    setState(() {
                                      if (selectedTopping.contains(
                                        toppings[index].id,
                                      )) {
                                        selectedTopping.remove(
                                          toppings[index].id,
                                        ); // remove if exists
                                      } else {
                                        selectedTopping.add(
                                          toppings[index].id,
                                        ); // add if not
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        loading: () => Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        error: (e, _) => Text("Error: $e"),
                      ),
                      Gap(16),
                      CustomText(text: 'Side Options', fontSize: 32),
                      Gap(16),
                      optionState.when(
                        data: (options) => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              options!.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(
                                  right: 16.0,
                                  bottom: 16.0,
                                ),
                                child: ToppingCard(
                                  imageUrl: options[index].imageUrl,
                                  title: options[index].name,
                                  isSelected: selectedOption.contains(
                                    options[index].id,
                                  ),
                                  onAdd: () {
                                    setState(() {
                                      if (selectedOption.contains(
                                        options[index].id,
                                      )) {
                                        selectedOption.remove(
                                          options[index].id,
                                        ); // remove if exists
                                      } else {
                                        selectedOption.add(
                                          options[index].id,
                                        ); // add if not
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        loading: () => Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        error: (e, _) => Text("Error: $e"),
                      ),

                      Gap(20),
                    ],
                  ),
                ),
              ),
        bottomSheet: loadProvider
            ? CircularProgressIndicator(color: AppColors.primaryColor)
            : IntrinsicHeight(
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
                            CustomText(text: '\$${widget.price}', fontSize: 16),
                          ],
                        ),
                        Spacer(),
                        CustomButton(
                          buttonText: 'Add To Cart',
                          onPressed: () {
                            // addToCart();
                            CartRepo cartRepo = CartRepo();

                            ///todo remove it inside cartProvider
                            cartRepo.resetItem();

                            cartModel.add(
                              CartModel(
                                widget.productId,
                                1,
                                spicyLevel,
                                selectedTopping.toList(),
                                selectedOption.toList(),
                              ),
                            );
                            ref
                                .read(cartRepoProvider)
                                .addToCart(CartRequest(cartModel), ref: ref);
                            //  addCartX();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
