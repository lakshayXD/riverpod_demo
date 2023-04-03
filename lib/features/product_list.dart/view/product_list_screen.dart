import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:infinity_box_task/features/product_details.dart/model/product.dart';
import 'package:infinity_box_task/features/product_list.dart/bloc/product_list_bloc.dart';
import 'package:infinity_box_task/features/product_list.dart/product_list_repository.dart';
import 'package:infinity_box_task/features/product_list.dart/view/widgets/product_card.dart';
import 'package:infinity_box_task/features/user_cart_list/view/user_cart_list_screen.dart';
import 'package:infinity_box_task/utils/color_constants.dart';
import 'package:infinity_box_task/widgets/custom_snack_bar.dart';
import 'package:infinity_box_task/widgets/loading_overlay.dart';

class ProductListScreen extends StatefulWidget {
  static const id = 'ProductListScreen';

  final String token;
  const ProductListScreen({super.key, required this.token});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();

  CategoryChipDeatils categoryChipDeatils = CategoryChipDeatils();

  List<Product> allProductsList = [];
  List<Product> productsList = [];

  Color activeChipTextColor = Colors.black;
  Color activeChipBackgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: BlocProvider<ProductListBloc>(
        create: (_) => ProductListBloc(ProductListRepository())
          ..add(AllProductListRequested()),
        child: BlocConsumer<ProductListBloc, ProductListState>(
          listener: (context, state) {
            if (state is AllProductListSuccess) {
              productsList = state.allProductsList;
              allProductsList = state.allProductsList;
              categoryChipDetailsSetter(
                  categoryChipDeatils, state.productCategoryList);
            } else if (state is AllProductListFailure) {
              showErrorSnackBar('Oops! Something went Wrong');
            } else if (state is FilterProductListSuccess) {
              productsList = state.filterProductsList;
            } else if (state is FilterProductListFaliure) {
              showErrorSnackBar('Oops! Something went Wrong');
            }
          },
          builder: (context, state) {
            return LoadingOverlay(
              isLoading: state is ProductListLoading,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Products'),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return _searchModalSheet(screenSize, context);
                                });
                          },
                          child: RichText(
                            text: const TextSpan(children: [
                              WidgetSpan(
                                  child: Icon(
                                Icons.search,
                                size: 18,
                              )),
                              TextSpan(
                                  text: ' Search',
                                  style: TextStyle(
                                      color: ColorConstants.primaryTextColor)),
                            ]),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, UserCartListScreen.id,
                                arguments: {'token': widget.token});
                          },
                          child: RichText(
                            text: const TextSpan(children: [
                              WidgetSpan(
                                  child: Icon(
                                Icons.shopping_cart,
                                size: 18,
                              )),
                              TextSpan(
                                  text: ' Cart',
                                  style: TextStyle(
                                      color: ColorConstants.primaryTextColor)),
                            ]),
                          )),
                    )
                  ],
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const Expanded(
                                flex: 1, child: Icon(Icons.filter_list)),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 8,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    categoryChipDeatils.categories.length,
                                itemBuilder: ((context, index) {
                                  return Row(
                                    children: <Widget>[
                                      FilterChip(
                                          label: Text(
                                            categoryChipDeatils
                                                .categories[index],
                                          ),
                                          labelStyle: TextStyle(
                                              color: categoryChipDeatils
                                                  .chipTextColors[index]),
                                          backgroundColor: categoryChipDeatils
                                              .chipBackgroundColors[index],
                                          selected: categoryChipDeatils
                                              .isSelected[index],
                                          onSelected: (val) {
                                            if (val) {
                                              setState(() {
                                                categoryChipDeatils
                                                        .chipBackgroundColors =
                                                    List.filled(
                                                        categoryChipDeatils
                                                            .count,
                                                        ColorConstants
                                                            .inactiveRatingBarColor);
                                                categoryChipDeatils
                                                        .chipTextColors =
                                                    List.filled(
                                                        categoryChipDeatils
                                                            .count,
                                                        ColorConstants
                                                            .activeRatingBarColor);
                                                categoryChipDeatils
                                                        .chipTextColors[index] =
                                                    activeChipTextColor;

                                                categoryChipDeatils
                                                            .chipBackgroundColors[
                                                        index] =
                                                    activeChipBackgroundColor;

                                                categoryChipDeatils.isSelected =
                                                    List.filled(
                                                        categoryChipDeatils
                                                            .count,
                                                        false);
                                                categoryChipDeatils
                                                    .isSelected[index] = true;
                                              });
                                              BlocProvider.of<ProductListBloc>(
                                                context,
                                                listen: false,
                                              ).add(FilterProductListRequested(
                                                  filter: categoryChipDeatils
                                                      .categories[index]));
                                            } else {
                                              setState(() {
                                                categoryChipDeatils
                                                        .chipTextColors[index] =
                                                    ColorConstants
                                                        .activeRatingBarColor;

                                                categoryChipDeatils
                                                            .chipBackgroundColors[
                                                        index] =
                                                    ColorConstants
                                                        .inactiveRatingBarColor;

                                                categoryChipDeatils
                                                    .isSelected[index] = false;

                                                productsList = allProductsList;
                                              });
                                            }
                                          }),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: RefreshIndicator(
                        onRefresh: refresh,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: AnimationLimiter(
                            child: GridView.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              childAspectRatio: 0.5,
                              children: List.generate(
                                productsList.length,
                                (int index) {
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    columnCount: 2,
                                    child: ScaleAnimation(
                                      child: FadeInAnimation(
                                        child: ProductCard(
                                          product: productsList[index],
                                          token: widget.token,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //searchTextField ModalSheet method
  Widget _searchModalSheet(Size screenSize, BuildContext context) {
    return BlocProvider<ProductListBloc>(
      create: (_) => ProductListBloc(ProductListRepository()),
      child: BlocConsumer<ProductListBloc, ProductListState>(
        listener: (context, state) {
          if (state is SearchProductListSuccess) {
            (state.searchProductsList.isEmpty)
                ? showErrorSnackBar('No results found!')
                : setState(() {
                    productsList = state.searchProductsList;
                  });
          } else if (state is SearchProductListFaliure) {
            showErrorSnackBar('Oops! Something went Wrong');
          }
        },
        builder: (context, state) {
          return Container(
            height: screenSize.height / 2,
            padding: const EdgeInsets.all(30),
            color: ColorConstants.inactiveRatingBarColor,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        String txt = _searchController.text.toLowerCase();
                        BlocProvider.of<ProductListBloc>(
                          context,
                          listen: false,
                        ).add(SearchProductListRequested(
                            product: txt, productList: productsList));
                        Navigator.of(context).pop();
                      },
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue)),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Product Name',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //for refreshing the screen
  Future<void> refresh() async {
    setState(() {
      categoryChipDeatils.chipBackgroundColors = List.filled(
          categoryChipDeatils.count, ColorConstants.inactiveRatingBarColor);
      categoryChipDeatils.chipTextColors = List.filled(
          categoryChipDeatils.count, ColorConstants.activeRatingBarColor);
      categoryChipDeatils.isSelected =
          List.filled(categoryChipDeatils.count, false);
      productsList = allProductsList;
    });
  }
}

//for setting up the categoryChipDetails instance
void categoryChipDetailsSetter(
    CategoryChipDeatils categoryChipDeatils, List<String> productCategoryList) {
  categoryChipDeatils.categories = productCategoryList;
  categoryChipDeatils.count = productCategoryList.length;
  categoryChipDeatils.chipBackgroundColors = List.filled(
      categoryChipDeatils.count, ColorConstants.inactiveRatingBarColor);
  categoryChipDeatils.chipTextColors = List.filled(
      categoryChipDeatils.count, ColorConstants.activeRatingBarColor);
  categoryChipDeatils.isSelected =
      List.filled(categoryChipDeatils.count, false);
}

//its instance contains the details of all the current category filters
class CategoryChipDeatils {
  int count;
  List<String> categories;
  List<Color> chipBackgroundColors;
  List<Color> chipTextColors;
  List<bool> isSelected;

  CategoryChipDeatils(
      {this.count = 0,
      this.categories = const <String>[],
      this.chipBackgroundColors = const <Color>[],
      this.chipTextColors = const <Color>[],
      this.isSelected = const <bool>[]});
}
