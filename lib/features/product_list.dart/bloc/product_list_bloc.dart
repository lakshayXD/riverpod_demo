import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_box_task/features/product_details.dart/model/product.dart';
import 'package:infinity_box_task/features/product_list.dart/product_list_repository.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductListRepository _repo;

  ProductListBloc(this._repo) : super(const ProductListInitial()) {
    on<AllProductListRequested>(_onAllProductListRequested);
    on<FilterProductListRequested>(_onFilterProductListRequested);
    on<SearchProductListRequested>(_onSearchProductListRequested);
  }

  void _onAllProductListRequested(
    AllProductListRequested event,
    Emitter<ProductListState> emit,
  ) async {
    emit(const ProductListLoading());
    try {
      final List<Product> allProductsList = await _repo.getAllProducts();
      final List<String> productCategoryList =
          await _repo.getProductCategories();
      emit(AllProductListSuccess(
          allProductsList: allProductsList,
          productCategoryList: productCategoryList));
    } catch (e) {
      emit(AllProductListFailure(e.toString()));
      addError(e);
    }
  }

  void _onFilterProductListRequested(
    FilterProductListRequested event,
    Emitter<ProductListState> emit,
  ) async {
    emit(const ProductListLoading());
    try {
      final List<Product> filterProductsList =
          await _repo.getFilterProducts(event.filter);
      emit(FilterProductListSuccess(filterProductsList: filterProductsList));
    } catch (e) {
      emit(FilterProductListFaliure(e.toString()));
      addError(e);
    }
  }

  void _onSearchProductListRequested(
    SearchProductListRequested event,
    Emitter<ProductListState> emit,
  ) async {
    emit(const ProductListLoading());
    try {
      final List<Product> searchProductsList =
          await _repo.getSearchProducts(event.product, event.productList);
      emit(SearchProductListSuccess(searchProductsList: searchProductsList));
    } catch (e) {
      emit(SearchProductListFaliure(e.toString()));
      addError(e);
    }
  }
}
