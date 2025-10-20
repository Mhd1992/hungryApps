import 'package:hungry/core/utils/exported_file.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  CustomWrapFilterChoice(
                    categories: categories,
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
