// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tk2_pbp/screens/notifications.dart';

import 'package:tk2_pbp/styles/styles.dart';
import 'package:tk2_pbp/components/menu_items.dart';
import 'package:tk2_pbp/helpers/authenticated_request.dart';
import 'package:tk2_pbp/components/page_header.dart';

class DonorCard extends StatelessWidget {
  const DonorCard({
    Key? key,
    this.icon,
    required this.title,
    required this.subtitle,
    required this.onAccept,
  }) : super(key: key);

  final Icon? icon;
  final String title;
  final String subtitle;
  final Function() onAccept;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.white,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Padding(
                child: Column(
                  children: [
                    ListTile(
                      leading: icon,
                      title: Text(title, style: TextStyles.menuItem),
                      subtitle: Container(
                        child: Text(
                          subtitle,
                          style: TextStyles.subtitleStyle,
                        ),
                        margin: const EdgeInsets.fromLTRB(0, 4.0, 0, 0),
                      ),
                      mouseCursor: SystemMouseCursors.click,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const SizedBox(width: 8),
                        TextButton(
                          child: Text(
                            'ACCEPT',
                            style: TextStyle(
                                color: Colors.green[400],
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: onAccept,
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 8.0)),
          ])),
    );
  }
}

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
          .get("http://localhost:8000/dashboard-donor/api/donor")
          .then((item) {
        List<dynamic> parsedList = item;
        setState(() {
          donors = item;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Iterable<DonorCard> donorComponents = donors.map((item) {
      Map<String, dynamic> donorData = jsonDecode(item['donor_data'])[0];
      return DonorCard(
          title: donorData['nama'],
          subtitle: "Golongan Darah: " +
              donorData['golongan_darah'] +
              donorData['rhesus'],
          onAccept: () {
            final request = Provider.of<CookieRequest>(context, listen: false);
            request.post("http://localhost:8000/dashboard-donor/api/donor",
                {"id": item["pk"].toString()});
          });
    });

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
                  title: "Request Details",
                  subtitle: "Click one of the requests to accept it."),
              ...donors.map((item) {
                return DonorCard(
                  title: item['nama'],
                  subtitle: "Golongan Darah: " +
                      item['golongan_darah'] +
                      item['rhesus'],
                  onAccept: () {},
                );
              })
            ],
          ),
        ));
  }
}
