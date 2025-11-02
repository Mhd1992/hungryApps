import 'package:hungry/core/networks/retrofit/model/category/category_model.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/home/data/repository/home_repo.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeRepo homeRepo = HomeRepo();
  bool _isLoading = false;

  List<CategoryModel> categoriesModels = [];
  @override
  void initState() {
    // TODO: implement initState
    getCategories();
    super.initState();
  }

  Future<void> getCategories() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final categories = await homeRepo.loadCategories();
      if (categories != null || categories.isNotEmpty) {
        categoriesModels = categories;
        setState(() {
          _isLoading = false;
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
                  _isLoading
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
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                childCount: 6,
                (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailView(),
                      ),
                    );
                  },
                  child: CardItem(
                    title: 'CheeseBurger',
                    imageUrl: 'assets/images/test.png',
                    description: 'Happy Burger',
                    rate: '️3.8',
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
