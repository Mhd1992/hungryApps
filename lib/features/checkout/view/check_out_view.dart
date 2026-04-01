import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/auth/data/repository/v1/auth_repo_v1.dart';
import 'package:hungry/features/checkout/data/repositorty/check_out_repo.dart';

import 'package:hungry/update_features/cart/cart/items/item_model.dart';

import '../../../update_features/cart/cart/request_cart/cart_item_model.dart'
    show CartItemModel;
import '../../../update_features/checkout/controller/checkout_controller.dart';
import '../../../update_features/checkout/model/orders/created_order_model.dart';
import '../../auth/view/controller/user_controller.dart';

class CheckOutView extends ConsumerStatefulWidget {
  const CheckOutView({
    super.key,
    required this.totalPrice,
    required this.cartItemModel,
  });

  final String totalPrice;
  final CartItemModel cartItemModel;

  @override
  ConsumerState<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends ConsumerState<CheckOutView> {
  final AuthRepoV1 authRepo = AuthRepoV1();

  final List<CartModel> orders = [];

  final List<CartItemModel> items = [];

  //final CheckoutRepo checkoutRepo = CheckoutRepo();

  Future<void> _checkout<T, P>({
    required Future<T> Function(P param) apiCall,
    required P param,
    required void Function(T) onSuccess,
  }) async {
    try {
      final result = await apiCall(param);
      if (result != null) {}
    } catch (e) {
      //if (contmounted) {
      //context.showSnackBar(e.toString());
      // }
    } finally {}
  }

  /*
  Future<void> checkout(List<CartModel> cartModel) async {
    await _checkout<String, CartRequest>(
      apiCall: checkoutRepo.checkout,
      param: CartRequest(cartModel),
      onSuccess: (data) => data,
    );
  }
*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(userControllerProvider.notifier).getProfile();
    });

    ref.listenManual<AsyncValue<CreatedOrderModel?>>(
      checkoutControllerProvider,
      (prev, next) {
        next.whenOrNull(
          data: (data) {
            if (data != null) {
              showDialog(
                context: context,
                builder: (context) =>
                    SuccessDialog(orderId: data.orderId.toString()),
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userControllerProvider);
    // List<CartModel> orders = [];
    final ValueNotifier<PaymentType?> paymentMethod =
        ValueNotifier<PaymentType?>(PaymentType.cash);
    final ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);
    double total = double.parse(widget.totalPrice) + 0.7 + 1.4;

    final state = ref.watch(checkoutControllerProvider);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: ValueListenableBuilder(
        valueListenable: paymentMethod,
        builder: (context, selectedMethod, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Order summary',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                OrderDetail(
                  order: double.parse(widget.totalPrice),
                  taxes: 0.7,
                  fees: 1.4,
                ),
                const Gap(80),
                const CustomText(
                  text: 'Payment methods',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                const Gap(20),

                PaymentListTile(
                  paymentLogo: 'assets/icons/cash.png',
                  text: 'Cash on Delivery',
                  value: PaymentType.cash,
                  groupValue: selectedMethod,
                  onChanged: (newVal) => paymentMethod.value = PaymentType.cash,
                ),
                const Gap(20),
                (user.value?.visa == null)
                    ? SizedBox.shrink()
                    : VisaListTile(
                        paymentLogo: 'assets/icons/visaSvg.svg',
                        text: 'Debit Card',
                        subTitleText: '3566 **** **** 0505',
                        value: PaymentType.visa,
                        groupValue: selectedMethod,
                        onChanged: (newVal) =>
                            paymentMethod.value = PaymentType.visa,
                      ),
                const Gap(20),

                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: isChecked,
                      builder: (context, value, _) => Checkbox(
                        value: isChecked.value,
                        onChanged: (val) => isChecked.value = val!,
                        activeColor: AppColors.primaryColor,
                      ),
                    ),
                    const CustomText(
                      text: 'Save card details for future payments',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),

      bottomSheet: IntrinsicHeight(
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: 'Total Price:',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      text: '\$${total.toStringAsFixed(3)}',
                      fontSize: 16,
                    ),
                  ],
                ),
                const Spacer(),
                state.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : CustomButton(
                        buttonText: 'Pay Now',
                        onPressed: () {
                          for (var e in widget.cartItemModel.items) {
                            orders.add(
                              CartModel(
                                e.productId,
                                e.quantity,
                                e.spicy,
                                e.toppingIds.map((t) => t.id).toList(),
                                e.optionIds.map((o) => o.id).toList(),
                              ),
                            );
                          }

                          ref
                              .read(checkoutControllerProvider.notifier)
                              .saveOrder(CartRequest(orders));

                          /*    final currentContext = context;

                    checkout(orders).then((val) {
                      if (currentContext.mounted) {
                        showDialog(
                          context: context,
                          builder: (context) => SuccessDialog(),
                        );
                      }
                    });*/
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum PaymentType { cash, visa }
