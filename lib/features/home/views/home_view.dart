import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/update_features/home/categories/controller/category_controller.dart';

import '../../../core/networks/error_widget.dart';
import '../../../update_features/home/home_controller.dart';
import '../../../update_features/home/products/controller/product_controller.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategoryIndex = useState(0);

    /// Run once (like initState)
    useEffect(() {
      Future.microtask(() {
        ref.read(categoryControllerProvider.notifier).getAllCategories();
        ref.read(productControllerProvider.notifier).loadAllProduct();
      });
      return null;
    }, const []);

    final homeState = ref.watch(homeScreenProvider);

    return homeState.when(
      data: (data) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              pinned: true,
              floating: false,
              scrolledUnderElevation: 0,
              toolbarHeight: 200,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
                child: Column(
                  children: const [UserHeader(), Gap(16), SearchField()],
                ),
              ),
            ),

            /// Categories
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 2,
              ),
              sliver: SliverToBoxAdapter(
                child: CustomWrapFilterChoice(
                  categories: data.categories,
                  selectedIndex: selectedCategoryIndex.value,
                  onChanged: (newIndex) {
                    selectedCategoryIndex.value = newIndex;
                  },
                ),
              ),
            ),

            /// Products Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: data.products.length,
                  (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProductDetailView(
                            productId: data.products[index].id,
                            price: data.products[index].price,
                          ),
                        ),
                      );
                    },
                    child: CardItem(
                      title: data.products[index].name,
                      imageUrl: data.products[index].imageUrl,
                      description: data.products[index].description,
                      rate: data.products[index].rating,
                    ),
                  ),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 0.75,
                ),
              ),
            ),
          ],
        ),
      ),
      error: (error, _) => AppErrorWidget(error: error),
      loading: () => Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      ),
    );
  }
}
