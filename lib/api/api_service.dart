// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
import 'Parameters.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://api.escuelajs.co/api/v1/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // flutter pub run build_runner build --delete-conflicting-outputs

  static ApiService create() {
    final dio = Dio();
    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
    );
    return ApiService(dio);
  }

  @GET('categories')
  Future<String> categories();

  @GET('products')
  Future<String> products();
}
