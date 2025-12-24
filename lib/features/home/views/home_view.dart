import 'package:hungry/core/utils/exported_file.dart';
import '../../../core/data/repositories/home/categories/categories_provider.dart';
import '../../../core/data/repositories/home/products/products_provider.dart';

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

      final productController = ref.read(productControllerProvider.notifier);
      productController.handleData(
        () => ref.read(productProvider).fetchProducts(ref: ref),
      );

      final categoryController = ref.read(categoryControllerProvider.notifier);
      categoryController.handleData(
        () => ref.read(categoriesProvider).fetchCategories(ref: ref),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productControllerProvider);
    final categoryState = ref.watch(categoryControllerProvider);

    final isLoading = productState.isLoading || categoryState.isLoading;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomScrollView(
        slivers: [
          _buildHeader(),
          if (isLoading)
            _buildLoading()
          else ...[
            /// Categories section
            _buildCategorySection(categoryState),

            /// Products section
            _buildProductSection(productState),
          ],
        ],
      ),
    );
  }

  SliverAppBar _buildHeader() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      pinned: true,
      toolbarHeight: 200,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
        child: Column(children: const [UserHeader(), Gap(16), SearchField()]),
      ),
    );
  }

  SliverFillRemaining _buildLoading() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      ),
    );
  }

  SliverPadding _buildCategorySection(
    AsyncValue<List<CategoryModel>?> categoryState,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      sliver: SliverToBoxAdapter(
        child: categoryState.when(
          data: (categories) => CustomWrapFilterChoice(
            categories: categories!,
            selectedIndex: _selectedCategoryIndex,
            onChanged: (newIndex) {
              setState(() => _selectedCategoryIndex = newIndex);
            },
          ),
          loading: () => Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
          error: (e, _) => Text("Error: $e"),
        ),
      ),
    );
  }

  Widget _buildProductSection(AsyncValue<List<ProductModel>?> productState) {
    return productState.when(
      data: (products) => SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          delegate: SliverChildBuilderDelegate(childCount: products!.length, (
            context,
            index,
          ) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailView(
                      productId: product.id,
                      price: product.price,
                    ),
                  ),
                );
              },
              child: CardItem(
                title: product.name,
                imageUrl: product.imageUrl,
                description: product.description,
                rate: product.rating,
              ),
            );
          }),
        ),
      ),
      loading: () => SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        ),
      ),
      error: (e, _) =>
          SliverToBoxAdapter(child: Center(child: Text("Error: $e"))),
    );
  }
}
