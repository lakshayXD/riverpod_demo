import 'package:shared_preferences/shared_preferences.dart';
import 'package:infinity_box_task/utils/base_repository.dart';

class ProductDetailsRepository with BaseRepository {
  //saving the given product in firestore 'cart' collection
  Future<void> addToCart(String token, int productId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? userProductCart = prefs.getStringList(token);
      if (userProductCart != null) {
        if (!userProductCart.contains(productId.toString())) {
          userProductCart.add(productId.toString());
          await prefs.setStringList(token, userProductCart);
        }
      } else {
        List<String> cart = [];
        cart.add(productId.toString());
        await prefs.setStringList(token, cart);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
