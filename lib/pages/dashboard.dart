library dashboard;

import 'package:flutter/material.dart';
import 'package:tk2_pbp/components/menu_items.dart';
import 'package:tk2_pbp/components/page_header.dart';
import 'package:provider/provider.dart';
import 'package:tk2_pbp/helpers/authenticated_request.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  DashboardState createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  final title = "Dashboard";
  CookieRequest request = CookieRequest();
  String username = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final _request = Provider.of<CookieRequest>(context, listen: false);

      if (!_request.loggedIn) {
        Navigator.popAndPushNamed(context, "/login");
      } else {
        setState(() {
          request = _request;
          username = _request.username ?? "";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          PageHeader(
              title: "Welcome to your dashboard, $username.",
              subtitle:
                  "Select one of the actions below to begin your KonvaSearch journey"),
          MenuItem(
              icon: const Icon(Icons.bloodtype_outlined, size: 32.0),
              title: "Donor Request",
              subtitle: "Create a donation request.",
              onClick: () {
                Navigator.pushNamed(context, "/request-pencari-donor");
              }),
          MenuItem(
              icon: const Icon(Icons.bloodtype, size: 32.0),
              title: "Respond to a Request",
              subtitle: "Respond to a donation request.",
              onClick: () {
                Navigator.pushNamed(context, "/respond-request");
              }),
        ],
      ),
    );
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
