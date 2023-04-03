import 'package:infinity_box_task/features/product_details.dart/model/product.dart';
import 'package:infinity_box_task/utils/base_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCartListRepository with BaseRepository {
  //fetching the cart list of the current user
  Future<List<Product>?> fetchUserCart(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? userProductCart = prefs.getStringList(token);

      print(
          '------------------------------------------------------> ${userProductCart}');

      List<Product> cartProductList = [];
      if (userProductCart != null && userProductCart.isNotEmpty) {
        for (String id in userProductCart) {
          final res = await dio.get('/products/${int.parse(id)}');
          cartProductList.add(Product.fromJson(res.data));
        }
        print(
            '------------------------------------------------------> END END END END');
        return cartProductList;
      }
      return null;
    } catch (e) {
      print('------------------------------------------------------> ${e}');
      throw Exception(e);
    }
  }

  //for deleting a product from the user cart
  Future<void> deleteCartItem(int productId, String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? userProductCart = prefs.getStringList(token);

      if (userProductCart != null && userProductCart.isNotEmpty) {
        if (userProductCart.contains(productId.toString())) {
          userProductCart.remove(productId.toString());
          await prefs.setStringList(token, userProductCart);
        }
      } else {
        throw Exception('Cart is Empty');
      }
    } catch (e) {
      throw Exception('Unable to delete! Please try again');
    }
  }
}
