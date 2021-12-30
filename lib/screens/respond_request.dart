// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tk2_pbp/helpers/authenticated_request.dart';
import 'package:tk2_pbp/components/menu_items.dart';
import 'package:tk2_pbp/components/page_header.dart';

import 'package:tk2_pbp/screens/request_pencari_donor_details.dart';
import 'package:tk2_pbp/screens/request_pencari_donor_potential.dart';
import 'package:tk2_pbp/screens/notifications.dart';

class ResponRequestDonor extends StatefulWidget {
  const ResponRequestDonor({Key? key}) : super(key: key);
  @override
  _ResponRequestDonorState createState() => _ResponRequestDonorState();
}

class _ResponRequestDonorState extends State<ResponRequestDonor> {
  List<dynamic> requestDonor = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final request = Provider.of<CookieRequest>(context, listen: false);
      request
          .get("http://localhost:8000/dashboard-pencari/api/request")
          .then((item) {
        setState(() {
          requestDonor = item;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Request Donor'),
          backgroundColor: const Color.fromRGBO(0, 41, 84, 1),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_alert),
              tooltip: 'Notification',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Notifications()));
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
            children: <Widget>[
              const PageHeader(
                  title: "Respond Request Donor",
                  subtitle: "You can accept or decline a donor request."),
              requestDonor.isEmpty
                  ? MenuItem(
                      icon: const Icon(Icons.bloodtype_outlined, size: 32.0),
                      title: "Create Donation Request",
                      subtitle:
                          "You have not created a Donation Request, click here to create one.",
                      onClick: () {})
                  : Column(children: [
                      MenuItem(
                          icon:
                              const Icon(Icons.bloodtype_outlined, size: 32.0),
                          title: "View Donation Request",
                          subtitle:
                              "Click here to view your Donation Request details.",
                          onClick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RequestDonorDetails()));
                          }),
                      MenuItem(
                          icon: const Icon(Icons.bloodtype, size: 32.0),
                          title: "View Potential Donors",
                          subtitle: "Click here to view Potential Donors.",
                          onClick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RequestDonorPotential()));
                          }),
                    ])
            ],
          ),
        ));
  }
}
