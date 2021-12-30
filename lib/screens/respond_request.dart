// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tk2_pbp/helpers/authenticated_request.dart';
import 'package:tk2_pbp/components/menu_items.dart';
import 'package:tk2_pbp/components/page_header.dart';

import 'package:tk2_pbp/screens/request_donor_details.dart';
import 'package:tk2_pbp/screens/request_donor_potential.dart';
import 'package:tk2_pbp/screens/notifications.dart';
import 'package:tk2_pbp/screens/request_donor_report.dart';
import 'package:tk2_pbp/screens/form_donor_screen.dart';

class RespondRequestDonorPage extends StatefulWidget {
  const RespondRequestDonorPage({Key? key}) : super(key: key);
  @override
  _RespondRequestDonorState createState() => _RespondRequestDonorState();
}

class _RespondRequestDonorState extends State<RespondRequestDonorPage> {
  List<dynamic> requestDonor = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final request = Provider.of<CookieRequest>(context, listen: false);
      request
          .get("http://localhost:8000/dashboard-donor/api/request")
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
          title: const Text('Request Pendonor'),
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
            IconButton(
                icon: const Icon(Icons.help_outline),
                tooltip: 'Support',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RequestDonorReport()),
                  );
                })
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
                  title: "Request Pendonor",
                  subtitle: "Select one of the actions below."),
              requestDonor.isEmpty
                  ? MenuItem(
                      icon: const Icon(Icons.bloodtype_outlined, size: 32.0),
                      title: "Create Donation Request",
                      subtitle:
                          "You have not created a Donation Request, click here to create one.",
                      onClick: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const FormDonorScreen();
                        }));
                      })
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
