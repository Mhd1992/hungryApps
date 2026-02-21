import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/constants/app_colors.dart';

import '../../../core/networks/error_widget.dart';
import '../../../shared/custom_text.dart';
import '../../../update_features/checkout/item_detail/contorller/item_detail_controller.dart';
import '../../product/widgets/spicy_slider.dart';
import '../widgets/topping_Item_card.dart';

class ItemDetail extends ConsumerStatefulWidget {
  final int id;

  const ItemDetail(this.id, {super.key});

  @override
  ConsumerState<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends ConsumerState<ItemDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(itemDetailControllerProvider.notifier).getOrder(widget.id);

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemDetailState = ref.watch(itemDetailControllerProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(8.0),

        child: itemDetailState.when(
          data: (data) {
            if (data != null) {
              return Column(
                children: [
                  // Scrollable content
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.orderItems.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.network(
                                          data.orderItems[index].image,
                                          width: 200,
                                        ),

                                        Gap(64),
                                        if (num.parse(
                                              data.orderItems[index].spicyLevel,
                                            ) >
                                            0)
                                          SpicySlider(
                                            value: double.parse(
                                              data.orderItems[index].spicyLevel,
                                            ),
                                            onChanged: null,
                                            hintText: false,
                                          ),
                                      ],
                                    ),
                                    Gap(20),
                                    CustomText(
                                      text: data.orderItems[index].name,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    CustomText(
                                      text:
                                          'Quantity : ${data.orderItems[index].quantity}'
                                              .toString(),
                                      fontSize: 16,
                                    ),
                                    CustomText(
                                      text:
                                          'price : \$ ${data.orderItems[index].price}',
                                      fontSize: 16,
                                    ),
                                    CustomText(
                                      text: data.createdAt,
                                      fontSize: 16,
                                    ),
                                    Gap(20),
                                    Divider(color: Colors.white, thickness: 2),

                                    Gap(20),
                                    Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (data
                                              .orderItems[index]
                                              .optionIds
                                              .isNotEmpty)
                                            CustomText(
                                              text: 'Side Options',
                                              fontSize: 16,
                                            ),
                                          Gap(8),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: List.generate(
                                                data
                                                    .orderItems[index]
                                                    .optionIds
                                                    .length,
                                                (i) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 16.0,
                                                        bottom: 16.0,
                                                      ),
                                                  child: ToppingItemCard(
                                                    imageUrl: data
                                                        .orderItems[index]
                                                        .optionIds[i]
                                                        .imageUrl,
                                                    title: data
                                                        .orderItems[index]
                                                        .optionIds[i]
                                                        .name,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          if (data
                                              .orderItems[index]
                                              .toppingIds
                                              .isNotEmpty)
                                            CustomText(
                                              text: 'Toppings',
                                              fontSize: 16,
                                            ),
                                          Gap(8),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: List.generate(
                                                data
                                                    .orderItems[index]
                                                    .toppingIds
                                                    .length,
                                                (i) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 16.0,
                                                        bottom: 16.0,
                                                      ),
                                                  child: ToppingItemCard(
                                                    imageUrl: data
                                                        .orderItems[index]
                                                        .toppingIds[i]
                                                        .imageUrl,
                                                    title: data
                                                        .orderItems[index]
                                                        .toppingIds[i]
                                                        .name,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Gap(40),
                                  ],
                                ),
                              ),
                            ),
                            Gap(24),
                          ],
                        );
                      },
                    ),
                  ),

                  // Fixed bottom section
                ],
              );
            } else {
              return Container();
            }
          },
          error: (error, _) => AppErrorWidget(error: error),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
