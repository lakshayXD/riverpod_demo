part of 'product_details_bloc.dart';

abstract class AddToCartState {
  const AddToCartState();
}

class AddToCartInitial extends AddToCartState {
  const AddToCartInitial();
}

class AddToCartLoading extends AddToCartState {
  const AddToCartLoading();
}

class AddToCartSuccess extends AddToCartState {
  const AddToCartSuccess();
}

class AddToCartFailure extends AddToCartState {
  final String err;
  const AddToCartFailure(this.err);
}
