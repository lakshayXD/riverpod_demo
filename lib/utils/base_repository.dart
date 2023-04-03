import 'package:infinity_box_task/utils/constants.dart';
import 'package:dio/dio.dart';

mixin BaseRepository {
  final _dio = Dio(
    BaseOptions(
      baseUrl: Constants.apiBaseUrl,
      headers: {'Content-Type': 'application/json'},
      connectTimeout: 15000,
    ),
  );

  Dio get dio => _dio;
}
