import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/constants/app_colors.dart';

import '../../../core/networks/error_widget.dart';
import '../../../shared/custom_text.dart';
import '../../../update_features/checkout/item_detail/contorller/item_detail_controller.dart';
import '../../../update_features/checkout/model/order_item/order_item_model.dart';
import '../../../update_features/product_details/side_option/data/side_option_model.dart';
import '../../../update_features/product_details/topping/data/topping_model.dart';
import '../../product/widgets/spicy_slider.dart';
import '../widgets/topping_Item_card.dart';

/// Padding and layout constants for the item detail screen.
abstract class _ItemDetailLayout {
  static const double screenPadding = 12;
  static const double cardPadding = 16;
  static const double cardRadius = 20;
  static const double itemImageWidth = 200;
  static const double contentGap = 20;
  static const double sectionGap = 24;
  static const double bottomGap = 40;
}

class ItemDetail extends ConsumerStatefulWidget {
  final int id;

  const ItemDetail(this.id, {super.key});

  @override
  ConsumerState<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends ConsumerState<ItemDetail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(itemDetailControllerProvider.notifier).getOrder(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemDetailState = ref.watch(itemDetailControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order details'),
        backgroundColor: theme.appBarTheme.backgroundColor ?? AppColors.primaryColor,
        foregroundColor: theme.appBarTheme.foregroundColor ?? Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(_ItemDetailLayout.screenPadding),
        child: itemDetailState.when(
          data: (data) {
            if (data == null || data.orderItems.isEmpty) {
              return _buildEmptyState(context);
            }
            return ListView.builder(
              itemCount: data.orderItems.length,
              itemBuilder: (context, index) {
                final item = data.orderItems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: _ItemDetailLayout.sectionGap),
                  child: _OrderItemCard(
                    item: item,
                    createdAt: data.createdAt,
                  ),
                );
              },
            );
          },
          error: (error, _) => AppErrorWidget(error: error),
          loading: () => Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey.shade400),
          const Gap(16),
          CustomText(
            text: 'No order details found',
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }
}

class _OrderItemCard extends StatelessWidget {
  const _OrderItemCard({
    required this.item,
    required this.createdAt,
  });

  final OrderItemModel item;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    final spicyLevel = double.tryParse(item.spicyLevel.toString()) ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(_ItemDetailLayout.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(_ItemDetailLayout.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.image,
                    width: _ItemDetailLayout.itemImageWidth,
                    height: _ItemDetailLayout.itemImageWidth,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: _ItemDetailLayout.itemImageWidth,
                      height: _ItemDetailLayout.itemImageWidth,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                const Gap(64),
                if (spicyLevel > 0)
                  SpicySlider(
                    value: spicyLevel,
                    onChanged: null,
                    hintText: false,
                  ),
              ],
            ),
            const Gap(_ItemDetailLayout.contentGap),
            CustomText(
              text: item.name,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            CustomText(
              text: 'Quantity: ${item.quantity}',
              fontSize: 16,
            ),
            CustomText(
              text: 'Price: \$${item.price}',
              fontSize: 16,
            ),
            CustomText(
              text: createdAt,
              fontSize: 16,
            ),
            const Gap(_ItemDetailLayout.contentGap),
            const Divider(color: Colors.white, thickness: 2),
            const Gap(_ItemDetailLayout.contentGap),
            if (item.optionIds.isNotEmpty) ...[
              CustomText(text: 'Side Options', fontSize: 16),
              const Gap(8),
              _buildOptionRow(item.optionIds),
              const Gap(_ItemDetailLayout.contentGap),
            ],
            if (item.toppingIds.isNotEmpty) ...[
              CustomText(text: 'Toppings', fontSize: 16),
              const Gap(8),
              _buildToppingRow(item.toppingIds),
            ],
            const Gap(_ItemDetailLayout.bottomGap),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionRow(List<SideOptionModel> options) {
    return _buildOptionOrToppingRow(
      options.map((o) => ToppingItemCard(imageUrl: o.imageUrl, title: o.name)).toList(),
    );
  }

  Widget _buildToppingRow(List<ToppingModel> options) {
    return _buildOptionOrToppingRow(
      options.map((o) => ToppingItemCard(imageUrl: o.imageUrl, title: o.name)).toList(),
    );
  }

  Widget _buildOptionOrToppingRow(List<ToppingItemCard> cards) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final card in cards)
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 16),
              child: card,
            ),
        ],
      ),
    );
  }
}
