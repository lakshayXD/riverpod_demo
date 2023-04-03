part of 'product_list_bloc.dart';

abstract class ProductListState {
  const ProductListState();
}

class ProductListInitial extends ProductListState {
  const ProductListInitial();
}

class ProductListLoading extends ProductListState {
  const ProductListLoading();
}

//-----------------------------------------------------

class AllProductListSuccess extends ProductListState {
  final List<Product> allProductsList;
  final List<String> productCategoryList;
  const AllProductListSuccess(
      {required this.productCategoryList, required this.allProductsList});
}

class AllProductListFailure extends ProductListState {
  final String err;
  const AllProductListFailure(this.err);
}

//------------------------------------------------------

class FilterProductListSuccess extends ProductListState {
  final List<Product> filterProductsList;
  const FilterProductListSuccess({required this.filterProductsList});
}

class FilterProductListFaliure extends ProductListState {
  final String err;
  const FilterProductListFaliure(this.err);
}

//------------------------------------------------------

class SearchProductListSuccess extends ProductListState {
  final List<Product> searchProductsList;
  const SearchProductListSuccess({required this.searchProductsList});
}

class SearchProductListFaliure extends ProductListState {
  final String err;
  const SearchProductListFaliure(this.err);
}
