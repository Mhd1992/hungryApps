import 'package:hungry/core/utils/exported_file.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.quantity,
    this.onAdd,
    this.onMin,
    this.onRemove,
    this.onChanged,
  });

  final String imageUrl, title, desc;
  final int quantity;

  final Function()? onAdd;
  final Function()? onMin;
  final Function()? onRemove;

  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(imageUrl, width: 100),
                      CustomText(text: title, fontWeight: FontWeight.bold),

                      CustomText(text: desc),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              onChanged?.call(quantity + 1);
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                CupertinoIcons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Gap(20),
                          CustomText(
                            text: '$quantity',
                            fontWeight: FontWeight.w500,
                          ),
                          Gap(20),
                          GestureDetector(
                            onTap: () {
                              if (quantity > 0) {
                                onChanged?.call(quantity - 1);
                              }
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                CupertinoIcons.minus,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(20),
                      GestureDetector(
                        onTap: onRemove,
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: CustomText(
                              text: 'Remove',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
