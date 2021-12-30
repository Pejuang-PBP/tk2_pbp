import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(210, 224, 239, 1),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(204, 23, 40, 1)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return const Color.fromRGBO(255, 0, 0, 1);
                }
                return null; // Defer to the widget's default.
              }),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/login");
            },
            child: const Text(
              "Login",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
