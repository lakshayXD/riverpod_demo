import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_box_task/features/product_details.dart/product_details_repository.dart';
part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final ProductDetailsRepository _repo;

  ProductDetailsBloc(this._repo) : super(const AddToCartInitial()) {
    on<AddToCartRequested>(_onAddToCartRequested);
  }

  void _onAddToCartRequested(
    AddToCartRequested event,
    Emitter<AddToCartState> emit,
  ) async {
    emit(const AddToCartLoading());
    try {
      await _repo.addToCart(event.currUserToken, event.productId);
      emit(const AddToCartSuccess());
    } catch (e) {
      emit(AddToCartFailure(e.toString()));
      addError(e);
    }
  }
}
