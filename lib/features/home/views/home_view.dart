import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/update_features/home/categories/controller/category_controller.dart';

import '../../../update_features/home/home_controller.dart';
import '../../../update_features/home/products/controller/product_controller.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(categoryControllerProvider.notifier).getAllCategories();
      ref.read(productControllerProvider.notifier).loadAllProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeScreenProvider);

    return homeState.when(
      data: (data) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          slivers: [
            ///Header of view
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              pinned: true,
              floating: false,
              scrolledUnderElevation: 0,
              toolbarHeight: 200,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: EdgeInsets.only(top: 40, left: 16, right: 16),
                child: Column(children: [UserHeader(), Gap(16), SearchField()]),
              ),
            ),

            /// Show one loading spinner if both APIs not ready

            ///body of view
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 2,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomWrapFilterChoice(
                      categories: data.categories,
                      selectedIndex: _selectedCategoryIndex,
                      onChanged: (newIndex) {
                        setState(() {
                          _selectedCategoryIndex = newIndex;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            ///footer of view
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: data.products.length,
                  (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductDetailView(
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 0.75,
                ),
              ),
            ),
          ],
        ),
      ),
      error: (error, _) => Text('Error'),
      loading: () => Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      ),
    );
  }
}
