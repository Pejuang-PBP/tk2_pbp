// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);
  @override
  FAQState createState() {
    return FAQState();
  }
}

class FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        // appBar: AppBar(
        //     title: Text("KonvaSearch")
        // ),
        appBar: AppBar(
       //title: 'KonvaSearch',
        title: Row(children: [
          Container(
              child: Image.asset(
                "assets/images/logo.png",
                width: 36.0,
                height: 36.0,
              ),
              margin: const EdgeInsets.fromLTRB(0, 0, 4.0, 0)),
          Text("KonvaSearch",
            style: const TextStyle(fontWeight: FontWeight.w600)),
        ]),
        backgroundColor: const Color.fromRGBO(0, 41, 84, 1),
        ),
        body: Center(
          child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Go Back")
          ),
        )
    );
  }
}