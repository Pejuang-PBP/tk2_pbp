import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:http/browser_client.dart';

class CookieRequest {
  Map<String, String> headers = {};
  final http.Client _client = http.Client();

  Future<Map> get(String url) async {
    if (_client is BrowserClient) {
      (_client as BrowserClient).withCredentials = true;
    }
    http.Response response =
        await _client.get(Uri.parse(url), headers: headers);
    updateCookie(response);
    return json.decode(response.body); // Expects and returns JSON request body
  }

  Future<Map> post(String url, dynamic data) async {
    if (_client is BrowserClient) {
      (_client as BrowserClient).withCredentials = true;
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
