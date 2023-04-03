part of 'user_cart_list_bloc.dart';

abstract class UserCartListEvent {
  const UserCartListEvent();
}

class UserCartListRequested extends UserCartListEvent {
  final String token;
  const UserCartListRequested({required this.token});
}

class DeleteCartItem extends UserCartListEvent {
  final int id;
  final String token;
  const DeleteCartItem({required this.token, required this.id});
}
