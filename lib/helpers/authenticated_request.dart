import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;

class CookieRequest {
  Map<String, String> headers = {};
  final http.Client _client = http.Client();
  bool loggedIn = false;

  Future<Map> login(String url, dynamic data) async {
    if (kIsWeb) {
      dynamic c = _client;
      c.withCredentials = true;
    }

    http.Response response =
        await _client.post(Uri.parse(url), body: data, headers: headers);

    updateCookie(response);

    if (response.statusCode == 200) {
      loggedIn = true;
    }
    return json.decode(response.body); // Expects and returns JSON request body
  }

  Future<Map> get(String url) async {
    if (kIsWeb) {
      dynamic c = _client;
      c.withCredentials = true;
    }
    http.Response response =
        await _client.get(Uri.parse(url), headers: headers);
    updateCookie(response);
    return json.decode(response.body); // Expects and returns JSON request body
  }

  Future<Map> post(String url, dynamic data) async {
    if (kIsWeb) {
      dynamic c = _client;
      c.withCredentials = true;
    }
    http.Response response =
        await _client.post(Uri.parse(url), body: data, headers: headers);
    updateCookie(response);
    return json.decode(response.body); // Expects and returns JSON request body
  }

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}
