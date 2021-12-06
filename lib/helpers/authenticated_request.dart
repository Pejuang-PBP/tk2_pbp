import 'package:http/http.dart' as http;
import 'dart:convert';

class CookieRequest {
  Map<String, String> headers = {};

  Future<Map> get(String url) async {
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    updateCookie(response);
    return json.decode(response.body); // Expects and returns JSON request body
  }

  Future<Map> post(String url, dynamic data) async {
    http.Response response =
        await http.post(Uri.parse(url), body: data, headers: headers);
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
