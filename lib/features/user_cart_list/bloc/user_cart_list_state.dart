part of 'user_cart_list_bloc.dart';

abstract class UserCartListState {
  const UserCartListState();
}

class UserCartListInitial extends UserCartListState {
  const UserCartListInitial();
}

class UserCartListLoading extends UserCartListState {
  const UserCartListLoading();
}

class UserCartListSuccess extends UserCartListState {
  final List<Product>? userCartList;
  const UserCartListSuccess({
    required this.userCartList,
  });
}

class UserCartListFailure extends UserCartListState {
  final String err;
  const UserCartListFailure(this.err);
}

class DeleteCartItemSuccess extends UserCartListState {
  const DeleteCartItemSuccess();
}

class DeleteCartItemFailure extends UserCartListState {
  final String err;
  const DeleteCartItemFailure(this.err);
}
