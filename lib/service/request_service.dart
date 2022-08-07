import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RequestService {

  static Future fetchJsonDataGetRequest(String url) {
    return
      http.get(Uri.parse(url))
          .then((response) => response.statusCode == 200 ? jsonDecode(response.body) : null)
          .catchError((err) => debugPrint(err));
  }

  static Future fetchJsonDataPostRequest(String url) {
    return
      http.post(Uri.parse(url))
          .then((response) => response.statusCode == 200 ? jsonDecode(response.body) : null)
          .catchError((err) => debugPrint(err));
  }
}