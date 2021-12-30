// ignore_for_file: unused_local_variable, avoid_print, unused_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tk2_pbp/screens/notifications.dart';
import 'package:tk2_pbp/screens/request_pencari_donor_report_details.dart';
import 'package:tk2_pbp/screens/request_pencari_donor_report_form.dart';

import 'package:tk2_pbp/components/menu_items.dart';
import 'package:tk2_pbp/helpers/authenticated_request.dart';
import 'package:tk2_pbp/components/page_header.dart';

class RequestDonorReport extends StatefulWidget {
  const RequestDonorReport({Key? key}) : super(key: key);
  @override
  _RequestDonorReportState createState() => _RequestDonorReportState();
}

class _RequestDonorReportState extends State<RequestDonorReport> {
  List<dynamic> notifications = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final request = Provider.of<CookieRequest>(context, listen: false);
      request
          .get("https://tk1-pbp.herokuapp.com/dashboard-pencari/api/report")
          .then((item) {
        setState(() {
          notifications = item;
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
              icon: const Icon(Icons.add),
              tooltip: 'Create Support Ticket',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RequestDonorReportForm()));
              },
            ),
          ],
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
                  title: "Support Center",
                  subtitle:
                      "If you have any problems, create a support ticket by pressing the button on the top right."),
              if (notifications.isEmpty)
                MenuItem(
                    title: "You do not have any ongoing reports",
                    subtitle:
                        "Please create a report if you are having any issues.",
                    onClick: () {})
              else
                ...notifications.map((item) {
                  return MenuItem(
                    title: item['title'],
                    subtitle: "Replies: " +
                        jsonDecode(item['replies']).length.toString(),
                    onClick: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RequestDonorReportDetails(item: item);
                      }));
                    },
                  );
                })
            ],
          ),
        ));
  }
}
