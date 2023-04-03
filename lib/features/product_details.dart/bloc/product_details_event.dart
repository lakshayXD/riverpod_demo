part of 'product_details_bloc.dart';

abstract class AddToCartEvent {
  const AddToCartEvent();
}

class AddToCartRequested extends AddToCartEvent {
  final String currUserToken;
  final int productId;
  AddToCartRequested({required this.currUserToken, required this.productId});
}
