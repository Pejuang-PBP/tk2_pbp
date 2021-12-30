import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tk2_pbp/helpers/authenticated_request.dart';

class AccountAuthedScreen extends StatefulWidget {
  const AccountAuthedScreen({Key? key}) : super(key: key);

  @override
  _AccountAuthedScreenState createState() => _AccountAuthedScreenState();
}

class _AccountAuthedScreenState extends State<AccountAuthedScreen> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    String? _username = request.username;

    return Container(
      color: const Color.fromRGBO(210, 224, 239, 1),
      child: Column(
        children: [
          const Spacer(),
          Text("Hello, $_username"),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(204, 23, 40, 1)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color.fromRGBO(255, 0, 0, 1);
                  }
                  return null;
                }),
              ),
              child: const Text("Logout"),
              onPressed: () async {
                await request.clear();
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
                    const Color.fromRGBO(204, 23, 40, 1)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color.fromRGBO(255, 0, 0, 1);
                  }
                  return null;
                }),
              ),
              child: const Text("Test Auth"),
              onPressed: () async {
                final response =
                    await request.post("https://tk1-pbp.herokuapp.com/test", {
                  "test": "blebloblu",
                });
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        children: [
                          Center(child: Text(response.toString())),
                        ],
                      );
                    });
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
