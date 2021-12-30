import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tk2_pbp/components/menu_items.dart';
import 'package:tk2_pbp/components/page_header.dart';
import 'package:tk2_pbp/helpers/authenticated_request.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {
  late CookieRequest request = CookieRequest();
  List<dynamic> notifications = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        request = Provider.of<CookieRequest>(context, listen: false);
        request
            .get(
                "https://tk1-pbp.herokuapp.com/dashboard-pencari/api/notifications")
            .then((res) {
          setState(() {
            notifications = res;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Notifications'),
          backgroundColor: const Color.fromRGBO(0, 41, 84, 1),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: ListView(
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
            children: <Widget>[
              const PageHeader(
                  title: "Your Notifications",
                  subtitle: "Here are your latest notifications."),
              ...notifications.map((item) {
                if (notifications.isNotEmpty) {
                  return MenuItem(
                      title: item['fields']['title'],
                      subtitle: item['fields']['message'],
                      onClick: () {});
                } else {
                  return const Text("EMPTY");
                }
              })
            ],
          ),
        ));
  }
}
