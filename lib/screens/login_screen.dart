import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import 'package:tk2_pbp/helpers/authenticated_request.dart';

void _showErrors(context, Map errors) {
  showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(child: Text(errors["message"].toString())),
            ),
          ],
        );
      });
}

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  String username = "";
  String password1 = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(210, 224, 239, 1),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 60,
              ),
              const Image(
                image: AssetImage('assets/images/logo.png'),
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 30,
              ),
              // Form
              Form(
                key: _loginFormKey,
                child: Column(
                  children: [
                    // Username
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(250, 250, 250, 0.95),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        onChanged: (String value) {
                          username = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Username',
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(200, 200, 200, 1),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Password
                    Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(250, 250, 250, 0.95),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          onChanged: (String value) {
                            password1 = value;
                          },
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              color: Color.fromRGBO(200, 200, 200, 1),
                            ),
                            suffixIcon: IconButton(
                              color: const Color.fromRGBO(200, 200, 200, 1),
                              splashRadius: 1,
                              icon: Icon(isPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: togglePasswordView,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password tidak boleh kosong";
                            }
                            return null;
                          },
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    // Login Button
                    // ignore: sized_box_for_whitespace
                    Container(
                      width: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(204, 23, 40, 1)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color.fromRGBO(255, 0, 0, 1);
                            }
                            return null;
                          }),
                        ),
                        onPressed: () async {
                          if (_loginFormKey.currentState!.validate()) {
                            final response = await request.login(
                              "https://tk1-pbp.herokuapp.com/auth/login", {
                              'username': username,
                              'password': password1,
                            });

                            if (request.loggedIn) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (Route<dynamic> route) => false);
                            } else {
                              _showErrors(context, response);
                            }
                          }
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                    text: "Belum memiliki akun?",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.popAndPushNamed(context, "/register");
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
