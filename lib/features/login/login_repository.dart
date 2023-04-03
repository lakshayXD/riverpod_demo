import 'dart:convert';

import 'package:infinity_box_task/utils/base_repository.dart';

class LoginRepository with BaseRepository {
  //method for logging in the user
  Future<String> logInUser(
      {required String userName, required String password}) async {
    Map<String, String> body = {'username': userName, 'password': password};

    try {
      final res = await dio.post('/auth/login', data: jsonEncode(body));

      return res.data['token'];
    } catch (e) {
      throw Exception('Login failed! Please try again');
    }
  }
}
