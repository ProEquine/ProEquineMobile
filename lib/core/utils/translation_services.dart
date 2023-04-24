import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as f;

TranslationService translationService = TranslationService();

class TranslationService {
  static const String deploymentID = 'AKfycbwT4lWlH7Pq9_JYf-FlrEAJSXXWzjlBRoEOnm8tEXTg91Ub0e7x4cph6uJ8WCC8671g8g';
  static const String url = "https://script.google.com/macros/s/$deploymentID/exec";

  Dio dio = Dio();

  addData(String value) async {
    if (!f.kDebugMode) {
      return;
    }
    try {
      await dio.post(
        url,
        queryParameters: {
          'value': value,
        },
      );
    } catch (_) {}
  }
}
