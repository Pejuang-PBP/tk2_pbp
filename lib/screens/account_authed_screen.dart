import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;

class AccountAuthedScreen extends StatefulWidget {
  const AccountAuthedScreen({ Key? key }) : super(key: key);

  @override
  _AccountAuthedScreenState createState() => _AccountAuthedScreenState();
}

class _AccountAuthedScreenState extends State<AccountAuthedScreen> {
  // final MyStorage _storage = MyStorage();
  final storage = const FlutterSecureStorage();

  String _jwt = "";
  String _username = "";

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    // final token = await _storage.read("token");
    final String token = (await storage.read(key: "token")).toString();

    final username = Jwt.parseJwt(token)["username"];
    setState(() {
      _jwt = token;
      _username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(210, 224, 239, 1),
      child: Column(
        children: [
          const Spacer(),

          Text("Hello, $_username"),
          const SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(204, 23, 40, 1)
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white
                ),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color.fromRGBO(255, 0, 0, 1);
                    }
                    return null; // Defer to the widget's default.
                  }
                ),
              ),
              child: const Text("Logout"),
              onPressed: () async {
                await storage.delete(key: "token");
                Navigator.popAndPushNamed(context, "/");
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(204, 23, 40, 1)
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white
                ),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color.fromRGBO(255, 0, 0, 1);
                    }
                    return null; // Defer to the widget's default.
                  }
                ),
              ),
              child: const Text("Test Auth"),
              onPressed: () async {
                final response = await http.post(
                  Uri.parse("http://10.0.2.2:8000/test-auth"),
                  // Uri.parse("http://localhost:8000/flutter-login"),

                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'token': _jwt,
                  })
                );

                if (response.statusCode == 200) {
                  // ignore: avoid_print
                  print(response.body);
                } else {
                  // ignore: avoid_print
                  print(jsonDecode(response.body)["errors"]);
                }
              },
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}