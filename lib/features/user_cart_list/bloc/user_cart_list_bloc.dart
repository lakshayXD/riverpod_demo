import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_box_task/features/product_details.dart/model/product.dart';
import 'package:infinity_box_task/features/user_cart_list/user_cart_list_repository.dart';

part 'user_cart_list_event.dart';
part 'user_cart_list_state.dart';

class UserCartListBloc extends Bloc<UserCartListEvent, UserCartListState> {
  final UserCartListRepository _repo;

  UserCartListBloc(this._repo) : super(const UserCartListInitial()) {
    on<UserCartListRequested>(_onUserCartListRequested);
    on<DeleteCartItem>(_onDeleteCartItem);
  }

  void _onUserCartListRequested(
    UserCartListRequested event,
    Emitter<UserCartListState> emit,
  ) async {
    emit(const UserCartListLoading());
    try {
      List<Product>? userCartList = await _repo.fetchUserCart(event.token);
      emit(UserCartListSuccess(userCartList: userCartList));
    } catch (e) {
      emit(UserCartListFailure(e.toString()));
      addError(e);
    }
  }

  void _onDeleteCartItem(
    DeleteCartItem event,
    Emitter<UserCartListState> emit,
  ) async {
    emit(const UserCartListLoading());
    try {
      await _repo.deleteCartItem(event.id, event.token);
      emit(const DeleteCartItemSuccess());
    } catch (e) {
      emit(DeleteCartItemFailure(e.toString()));
      addError(e);
    }
  }
}
