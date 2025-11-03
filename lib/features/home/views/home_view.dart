import 'package:hungry/core/networks/retrofit/model/category/category_model.dart';
import 'package:hungry/core/networks/retrofit/model/products/product_model.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/home/data/repository/home_repo.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeRepo homeRepo = HomeRepo();
  bool _isCategoryLoading = false;
  bool _isProductLoading = false;

  List<CategoryModel> categoriesModels = [];
  List<ProductModel> productModels = [];
  @override
  void initState() {
    // TODO: implement initState
    getCategories();
    getProducts();
    super.initState();
  }

  Future<void> getCategories() async {
    try {
      setState(() {
        _isCategoryLoading = true;
      });
      final categories = await homeRepo.loadCategories();
      if (categories != null || categories.isNotEmpty) {
        categoriesModels = categories;
        setState(() {
          _isCategoryLoading = false;
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

  Future<void> getProducts() async {
    try {
      setState(() {
        _isProductLoading = true;
      });
      final products = await homeRepo.loadProducts();
      if (products != null || products.isNotEmpty) {
        productModels = products;
        setState(() {
          _isProductLoading = false;
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

  int _selectedCategoryIndex = 0;
  List<String> categories = [
    'All',
    'Combo',
    'Sliders',
    'Juice',
    'chickenBurger',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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

          ///body of view
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  _isCategoryLoading
                      ? CircularProgressIndicator(color: AppColors.primaryColor)
                      : CustomWrapFilterChoice(
                          categories: categoriesModels,
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
          _isProductLoading
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
              : SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      childCount: productModels.length,
                      (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetailView(),
                            ),
                          );
                        },
                        child: CardItem(
                          title: productModels[index].name,
                          imageUrl: productModels[index].imageUrl,
                          description: productModels[index].description,
                          rate: productModels[index].rating,
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
    );
  }
}
