import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/networks/retrofit/model/cart/items/item_model.dart';
import 'package:hungry/core/networks/retrofit/model/cart/request_cart/cart_item_model.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/auth/data/repository/v1/auth_repo_v1.dart';
import 'package:hungry/features/checkout/data/provider/check_view_provider.dart';
import 'package:hungry/features/checkout/view/enum/payment_type.dart';

class CheckOutViewV1 extends ConsumerWidget {
  CheckOutViewV1({
    super.key,
    required this.totalPrice,
    required this.cartItemModel,
  });

  final String totalPrice;
  final CartItemModel cartItemModel;

  final AuthRepoV1 authRepo = AuthRepoV1();
  final List<CartModel> orders = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double total = double.parse(totalPrice) + 0.7 + 1.4;
    final isGuestProvider = ref.watch(guestProvider);
    final checked = ref.watch(checkedProvider);
    final hasVisa = ref.watch(visaProvider);
    final selectedPayment = ref.watch(paymentTypeProvider);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Order summary',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            OrderDetail(order: double.parse(totalPrice), taxes: 0.7, fees: 1.4),
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
              groupValue: selectedPayment,
              onChanged: (newVal) =>
                  ref.read(paymentTypeProvider.notifier).state = newVal,
            ),
            const Gap(20),
            (hasVisa)
                ? SizedBox.shrink()
                : VisaListTile(
                    paymentLogo: 'assets/icons/visaSvg.svg',
                    text: 'Debit Card',
                    subTitleText: '3566 **** **** 0505',
                    value: PaymentType.visa,
                    groupValue: selectedPayment,
                    onChanged: (newVal) =>
                        ref.read(paymentTypeProvider.notifier).state = newVal,
                  ),
            const Gap(20),

            Row(
              children: [
                Checkbox(
                  value: checked,
                  onChanged: (val) {
                    ref.read(checkedProvider.notifier).state = val!;
                  },
                  activeColor: AppColors.primaryColor,
                ),
                const CustomText(text: 'Save card details for future payments'),
              ],
            ),
          ],
        ),
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
                  mainAxisSize: MainAxisSize.min, // 👈 important!
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
                CustomButton(
                  buttonText: 'Pay Now',
                  onPressed: () {
                    for (var e in cartItemModel.items) {
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
                    final currentContext = context;
                    checkoutV1(CartRequest(orders), ref: ref).then((val) {
                      if (currentContext.mounted) {
                        showDialog(
                          context: context,
                          builder: (context) => SuccessDialog(),
                        );
                      }
                    });

                    /*   checkout(orders).then((val) {
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
