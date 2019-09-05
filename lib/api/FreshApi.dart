import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class FreshApi {
  Dio dio;
  String basePath = "";

  FreshApi({this.dio}) {
    if (dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: basePath,
        connectTimeout: 5000,
        receiveTimeout: 3000,
      );
      dio = Dio(options);
    }

    (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
  }
}

// Must be top-level function
void _parseAndDecode(String response) {
  return jsonDecode(response);
}

Future<void> parseJson(String text) {
  return compute(_parseAndDecode, text);
}
