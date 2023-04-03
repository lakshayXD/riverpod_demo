import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_box_task/features/product_details.dart/bloc/product_details_bloc.dart';
import 'package:infinity_box_task/features/product_details.dart/model/product.dart';
import 'package:infinity_box_task/features/product_details.dart/product_details_repository.dart';
import 'package:infinity_box_task/features/user_cart_list/view/user_cart_list_screen.dart';
import 'package:infinity_box_task/utils/color_constants.dart';
import 'package:infinity_box_task/widgets/custom_snack_bar.dart';
import 'package:infinity_box_task/widgets/loading_overlay.dart';
import 'package:infinity_box_task/widgets/star_rating_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const id = 'ProductDetailsScreen';

  final Product product;
  final String token;
  const ProductDetailsScreen(
      {super.key, required this.product, required this.token});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: BlocProvider<ProductDetailsBloc>(
        create: (_) => ProductDetailsBloc(ProductDetailsRepository()),
        child: BlocConsumer<ProductDetailsBloc, AddToCartState>(
          listener: (context, state) {
            if (state is AddToCartSuccess) {
              showSuccessSnackBar(
                  'Product is added to your cart successfully!');
            } else if (state is AddToCartFailure) {
              showErrorSnackBar(state.err);
            }
          },
          builder: (context, state) {
            return LoadingOverlay(
              isLoading: state is AddToCartLoading,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Product Details'),
                  actions: [
                    Padding(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, UserCartListScreen.id,
                                    arguments: {'token': token});
                              },
                              child: RichText(
                                text: const TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(
                                    Icons.shopping_cart,
                                    size: 18,
                                  )),
                                  TextSpan(
                                      text: '  Cart',
                                      style: TextStyle(
                                          color:
                                              ColorConstants.primaryTextColor)),
                                ]),
                              )),
                        ))
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: screenSize.height / 2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(product.imageUrl),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: ColorConstants
                                    .movieDetailBackgroundGradientList,
                                stops: [0.0, 0.6, 0.8])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    product.title,
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Category: ${product.category}',
                                  style: Theme.of(context).textTheme.headline4,
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                product.description,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            (product.rating != null)
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                StarRatingBar(
                                                  productRating:
                                                      product.rating['rate']!,
                                                  ratingBarBackgroundColor:
                                                      ColorConstants
                                                          .inactiveRatingBarColor,
                                                ),
                                                Text(
                                                    ' (${product.rating['count']!.toInt()})'),
                                              ],
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: ColorConstants.redAccent,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                '₹ ${product.price}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                            ),
                                          ],
                                        )))
                                : const SizedBox(),
                            const SizedBox(
                              height: 60,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<ProductDetailsBloc>(context)
                                        .add(AddToCartRequested(
                                            currUserToken: token,
                                            productId: product.id));
                                  },
                                  child: RichText(
                                      text: const TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(
                                      Icons.shopping_cart,
                                      size: 18,
                                    )),
                                    TextSpan(text: ' Add to cart'),
                                  ]))),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
