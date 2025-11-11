import 'package:hungry/core/networks/retrofit/model/cart/request_cart/cart_item_model.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/cart/data/repository/cart_repository.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    CartRepo cartRepo = CartRepo();
    AuthRepo authRepo = AuthRepo();
    CartItemModel? cartItems;

    final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
    final ValueNotifier<int> initialValue = ValueNotifier<int>(0);
    final ValueNotifier<CartItemModel?> cartItemsNotifier =
        ValueNotifier<CartItemModel?>(null);

    int totalQty = 1;

    void setLoadingState(bool value) {
      isLoading.value = value;
    }

    List<ValueNotifier<int>> quantities = [];

    isLoading.value = false;

    Future<void> _loadCartItems<T>({
      required Future<T> Function() apiCall,
      required void Function(T) onSuccess,
    }) async {
      try {
        //  setLoadingState(true);
        final result = await apiCall();
        if (result != null) {
          //  cartItems = result as CartItemModel;
          onSuccess(result);
          setLoadingState(false);
        }
      } catch (e) {
        String errorMessage = 'Unknown error';
        if (e is ApiError) {
          errorMessage = e.message;
        }
      } finally {
        //  setLoadingState(false);
      }
    }

    Future<void> loadCartItems() async {
      await _loadCartItems(
        apiCall: cartRepo.getCartItem,
        onSuccess: (data) {
          print(data);
          cartItems = data;
          cartItemsNotifier.value = data;
          quantities = cartItems!.items
              .map((e) => ValueNotifier<int>(e.quantity))
              .toList();
        },
      );
    }

    Future<void> removeCartItem<T, P>({
      required Future<T> Function(P param) apiCall,
      required P param,
      required void Function(T) onSuccess,
    }) async {
      try {
        setLoadingState(true);
        final result = await apiCall(param);
        if (result != null) {
          onSuccess(result);
          setLoadingState(false);
        }
      } catch (e) {
        String errorMessage = 'Unknown error';
        if (e is ApiError) {
          errorMessage = e.message;
        }
      } finally {
        setLoadingState(false);
      }
    }

    Future<void> removeItem(int cartId) async {
      try {
        setLoadingState(true);
        await removeCartItem(
          apiCall: cartRepo.removeFromCart,
          param: cartId,
          onSuccess: (data) {
            loadCartItems();
            context.showSnackBar(data);
          },
        );
      } catch (e) {
        String errorMessage = 'Unknown error';
        if (e is ApiError) {
          errorMessage = e.message;
        }
      } finally {
        setLoadingState(false);
      }
    }

    return FutureBuilder<void>(
      future: loadCartItems(),
      builder: (context, asyncSnapshot) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
          ),
          body: (authRepo.isGuest)
              ? GuestLogo()
              : Skeletonizer(
                  enabled: cartItems == null,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: isLoading,
                    builder: (context, isLoadingValue, _) {
                      if (isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      }
                      return ValueListenableBuilder<CartItemModel?>(
                        valueListenable: cartItemsNotifier,
                        builder: (context, cartData, child) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                (cartData != null && cartData.items.isNotEmpty)
                                ? Column(
                                    children: [
                                      // Scrollable content
                                      Expanded(
                                        child: ListView.builder(
                                          padding: EdgeInsets.only(
                                            bottom: 20,
                                            top: 20,
                                          ),
                                          itemCount: cartData?.items.length,
                                          itemBuilder: (context, index) {
                                            return ValueListenableBuilder<int>(
                                              valueListenable:
                                                  (quantities.isNotEmpty)
                                                  ? quantities[index]
                                                  : initialValue,
                                              builder: (context, value, _) {
                                                return CartItem(
                                                  title: cartItems
                                                      ?.items[index]
                                                      .name,
                                                  imageUrl: cartItems
                                                      ?.items[index]
                                                      .imageUrl,
                                                  desc: '',
                                                  quantity: value,
                                                  onChanged: (newValue) {
                                                    quantities[index].value =
                                                        newValue;
                                                    cartItems?.items[index] =
                                                        cartItems!.items[index]
                                                            .copyWith(
                                                              quantity:
                                                                  quantities[index]
                                                                      .value,
                                                            );
                                                    //  cartItems?.items[index].quantity = quantities[index].value;
                                                  },
                                                  onRemove: () {
                                                    removeItem(
                                                      cartData
                                                              ?.items[index]
                                                              .itemId ??
                                                          0,
                                                    );
                                                    cartData?.items.remove(
                                                      cartData.items[index],
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),

                                      // Fixed bottom section
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 8.0,
                                        ),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: 'Total Price:',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                CustomText(
                                                  text:
                                                      (cartData != null &&
                                                          cartData
                                                              .items
                                                              .isNotEmpty)
                                                      ? '\$${cartData?.totalPrice}'
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
                                                      return CheckOutView(
                                                        cartItemModel:
                                                            cartData!,
                                                        totalPrice: cartData
                                                            ?.totalPrice,
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
                                  )
                                : Center(
                                    child: CustomText(
                                      text: 'No data.',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          );
                        },
                      );
                    },
                  ),
                ),
          /*    bottomSheet: IntrinsicHeight(
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
                    color: Colors.grey.shade800,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, // 👈 important!
                      children: const [
                        CustomText(
                          text: 'Total Price:',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomText(text: '\$11.15', fontSize: 16),
                      ],
                    ),
                    const Spacer(),
                    CustomButton(
                      buttonText: 'Pay Now',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => SuccessDialog(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),*/
        );
      },
    );
  }
}

///    /// Start loading when widget builds
///    like initState and futureBuilder in statelessWidget
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       loadCartItem();
//     });
