import 'package:hungry/core/networks/retrofit/model/cart/items/item_model.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/cart/data/repository/cart_repository.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  List<ToppingModel> toppings = [];
  List<SideOptionModel> options = [];
  Set<int> selectedToppings = {};
  Set<int> selectedOptions = {};
  double spicyLevel = 0.5;
  ProductOptionRepo productOptionRepo = ProductOptionRepo();
  bool _isAllLoading = false;
  CartRepo cartRepo = CartRepo();
  List<CartModel> cartModel = [];
  bool _isAdded = false;

  @override
  void initState() {
    // TODO: implement initState
    _loadAllData();
    super.initState();
  }

  Future<void> _loadAllData() async {
    setState(() => _isAllLoading = true);

    await Future.wait([loadToppings(), loadSideOptions()]);

    setState(() => _isAllLoading = false);
  }

  /*  Future<void> loadSideOptions() async {
    try {
      final loadedOptions = await productOptionRepo.loadSideOptions();
      if (loadedOptions.isNotEmpty) {
        setState(() {
          options = loadedOptions;
        });
      }
    } catch (e) {
      String errorMessage = 'unknown Error';
      if (e is ApiError) {
        errorMessage = e.message;
        if (mounted) {
          context.showSnackBar(errorMessage);
        }
      }
    }
  }

  Future<void> loadToppings() async {
    try {
      final loadedToppings = await productOptionRepo.loadToppings();
      if (loadedToppings.isNotEmpty) {
        setState(() {
          toppings = loadedToppings;
        });
      }
    } catch (e) {
      String errorMessage = 'unknown Error';
      if (e is ApiError) {
        errorMessage = e.message;
        if (mounted) {
          context.showSnackBar(errorMessage);
        }
      }
    }
  }*/

  Future<void> loadSideOptions() async {
    await _loadProductOptions(
      apiCall: productOptionRepo.loadSideOptions,
      onSuccess: (data) => options = data,
    );
  }

  Future<void> loadToppings() async {
    await _loadProductOptions(
      apiCall: productOptionRepo.loadToppings,
      onSuccess: (data) => toppings = data,
    );
  }

  Future<void> _loadProductOptions<T>({
    required Future<List<T>> Function() apiCall,
    required void Function(List<T>) onSuccess,
  }) async {
    try {
      final result = await apiCall();
      if (result.isNotEmpty) {
        setState(() {
          onSuccess(result);
        });
      }
    } catch (e) {
      String errorMessage = 'Unknown error';
      if (e is ApiError) {
        errorMessage = e.message;
        if (mounted) {
          context.showSnackBar(errorMessage);
        }
      }
    }
  }

  /*

  Future<void> a() async {
    await _loadProductOptionsP<ToppingModel, int>(
      apiCall: productOptionRepo.loadToId,
      param: 1,
      onSuccess: (data) => toppings = data,
    );
  }
  Future<void> _loadProductOptionsP<T, P>({
    required Future<T> Function(P param) apiCall,
    required P param,
    required void Function(List<T>) onSuccess,
  }) async {
    try {
      final result = await apiCall(param);
     if (result != null) {
        setState(() {
      //    onSuccess(result);
        });
      }
    } catch (e) {
      String errorMessage = 'Unknown error';
      if (e is ApiError) {
        errorMessage = e.message;
        if (mounted) {
          context.showSnackBar(errorMessage);
        }
      }
    }
  }
*/

  Future<void> addToCart() async {
    try {
      setState(() {
        _isAdded = true;
      });
      cartModel.add(
        CartModel(
          widget.productId,
          1,
          spicyLevel,
          selectedToppings.toList(),
          selectedOptions.toList(),
        ),
      );
      final response = await cartRepo.addToCart(CartRequest(cartModel));
      if (response.isNotEmpty) {
        if (!mounted) return;
        context.showSnackBar(response);
      }
    } catch (e) {
      String errorMessage = 'unknown Error';
      if (e is ApiError) {
        errorMessage = e.message;
        if (mounted) {
          context.showSnackBar(errorMessage);
        }
      }
    } finally {
      setState(() {
        _isAdded = false;
      });
    }
  }

  Future<void> addCartX() async {
    cartModel.add(
      CartModel(
        widget.productId,
        1,
        spicyLevel,
        selectedToppings.toList(),
        selectedOptions.toList(),
      ),
    );
    await _addToCaretX<String, CartRequest>(
      apiCall: cartRepo.addToCart,
      param: CartRequest(cartModel),
      onSuccess: (data) => data,
    );
  }

  Future<void> _addToCaretX<T, P>({
    required Future<T> Function(P param) apiCall,
    required P param,
    required void Function(T) onSuccess,
  }) async {
    try {
      setState(() {
        _isAdded = true;
      });
      final result = await apiCall(param);
      if (result != null) {
        setState(() {
          onSuccess(result);
          print('------------\n$result\n--------------');
        });
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(e.toString());
      }
    } finally {
      setState(() {
        _isAdded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white),
        body: _isAllLoading
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

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            toppings.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(
                                right: 16.0,
                                bottom: 16.0,
                              ),
                              child: ToppingCard(
                                imageUrl: toppings[index].imageUrl,
                                title: toppings[index].name,
                                isSelected: selectedToppings.contains(
                                  toppings[index].id,
                                ),
                                onAdd: () {
                                  setState(() {
                                    if (selectedToppings.contains(
                                      toppings[index].id,
                                    )) {
                                      selectedToppings.remove(
                                        toppings[index].id,
                                      ); // remove if exists
                                    } else {
                                      selectedToppings.add(
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
                      Gap(16),
                      CustomText(text: 'Side Options', fontSize: 32),
                      Gap(16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            options.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(
                                right: 16.0,
                                bottom: 16.0,
                              ),
                              child: ToppingCard(
                                imageUrl: options[index].imageUrl,
                                title: options[index].name,
                                isSelected: selectedOptions.contains(
                                  options[index].id,
                                ),
                                onAdd: () {
                                  setState(() {
                                    if (selectedOptions.contains(
                                      options[index].id,
                                    )) {
                                      selectedOptions.remove(
                                        options[index].id,
                                      ); // remove if exists
                                    } else {
                                      selectedOptions.add(
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
                      Gap(20),
                    ],
                  ),
                ),
              ),
        bottomSheet: _isAdded
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
                            CustomText(text: ' \$12.99', fontSize: 16),
                          ],
                        ),
                        Spacer(),
                        CustomButton(
                          buttonText: 'Add To Cart',
                          onPressed: () {
                            // addToCart();
                            addCartX();
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
