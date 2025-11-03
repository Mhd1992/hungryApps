import 'package:hungry/core/networks/retrofit/model/side_option/side_option_model.dart';
import 'package:hungry/core/networks/retrofit/model/topping/topping_model.dart';
import 'package:hungry/core/utils/exported_file.dart';
import 'package:hungry/features/product/data/repository/product_option_repo.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  List<ToppingModel> toppings = [];
  List<SideOptionModel> options = [];
  bool _isToppingLoading = false;
  bool _isSideOptionLoading = false;
  double spicyLevel = 0.5;
  ProductOptionRepo productOptionRepo = ProductOptionRepo();

  @override
  void initState() {
    // TODO: implement initState
    loadToppings();
    loadSideOptions();

    super.initState();
  }

  Future<void> loadSideOptions() async {
    try {
      setState(() {
        _isSideOptionLoading = true;
      });
      final loadedOptions = await productOptionRepo.loadSideOptions();
      if (loadedOptions.isNotEmpty) {
        setState(() {
          options = loadedOptions;
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
    } finally {
      setState(() {
        _isSideOptionLoading = false;
      });
    }
  }

  Future<void> loadToppings() async {
    try {
      setState(() {
        _isToppingLoading = true;
      });
      final loadedToppings = await productOptionRepo.loadToppings();
      if (loadedToppings != null || loadedToppings.isNotEmpty) {
        setState(() {
          toppings = loadedToppings;
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
    } finally {
      setState(() {
        _isToppingLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/detail.png', height: 250),
                  Gap(64),
                  SpicySlider(
                    value: spicyLevel,
                    onChanged: (value) {
                      setState(() => spicyLevel = value);
                    },
                  ),
                ],
              ),
              Gap(16),
              CustomText(text: 'Toppings', fontSize: 32),
              Gap(16),

              _isToppingLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          toppings!.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(
                              right: 16.0,
                              bottom: 16.0,
                            ),
                            child: ToppingCard(
                              imageUrl: toppings![index].imageUrl,
                              title: toppings![index].name,
                              onAdd: () {},
                            ),
                          ),
                        ),
                      ),
                    ),
              Gap(16),
              CustomText(text: 'Side Options', fontSize: 32),
              Gap(16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    options.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
                      child: ToppingCard(
                        imageUrl:
                            options![index].imageUrl ??
                            'https://via.placeholder.com/150',
                        title: options![index].name,
                        onAdd: () {},
                      ),
                    ),
                  ),
                ),
              ),
              Gap(20),
            ],
          ),
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
                color: Colors.grey.shade900,
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
                  children: [
                    CustomText(
                      text: 'Total Price:',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(text: ' \$12.99', fontSize: 16),
                  ],
                ),
                Spacer(),
                CustomButton(buttonText: 'Add To Cart', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
