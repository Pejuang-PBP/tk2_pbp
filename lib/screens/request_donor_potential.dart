// ignore_for_file: unused_local_variable, avoid_print

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tk2_pbp/helpers/authenticated_request.dart';
import 'package:tk2_pbp/components/page_header.dart';

class RequestDonorPotential extends StatefulWidget {
  const RequestDonorPotential({Key? key}) : super(key: key);
  @override
  _RequestDonorPotentialState createState() => _RequestDonorPotentialState();
}

class _RequestDonorPotentialState extends State<RequestDonorPotential> {
  List<dynamic> donors = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final request = Provider.of<CookieRequest>(context, listen: false);
      request
          .get("http://localhost:8000/dashboard-pencari/api/donor")
          .then((item) {
        print(item);
        setState(() {
          donors = item;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Request Details'),
          backgroundColor: const Color.fromRGBO(0, 41, 84, 1),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_alert),
              tooltip: 'Notification',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is notifications')));
              },
            ),
          ],
        ),
        body: Center(
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
            children: const <Widget>[
              PageHeader(
                  title: "Request Details",
                  subtitle: "The following is information about your request."),
            ],
          ),
        ));
  }
}
