// ignore_for_file: unused_local_variable, avoid_print

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tk2_pbp/helpers/authenticated_request.dart';
import 'package:tk2_pbp/components/menu_items.dart';
import 'package:tk2_pbp/components/page_header.dart';
import 'package:tk2_pbp/screens/notifications.dart';

class RequestDonorDetails extends StatefulWidget {
  const RequestDonorDetails({Key? key}) : super(key: key);
  @override
  _RequestDonorDetailsState createState() => _RequestDonorDetailsState();
}

class _RequestDonorDetailsState extends State<RequestDonorDetails> {
  List<dynamic> requestDonor = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final request = Provider.of<CookieRequest>(context, listen: false);
      request
          .get("https://tk1-pbp.herokuapp.com/dashboard-pencari/api/request")
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
                  subtitle: "The following is information about your request."),
              requestDonor.isNotEmpty
                  ? Column(
                      children: [
                        MenuItem(
                            onClick: () {},
                            title: "Name",
                            subtitle: requestDonor[0]["fields"]["nama"]),
                        MenuItem(
                            onClick: () {},
                            title: "Nomor Induk Kependudukan",
                            subtitle: requestDonor[0]["fields"]["nomor_induk"]),
                        MenuItem(
                            onClick: () {},
                            title: "Nomor Telepon",
                            subtitle: requestDonor[0]["fields"]["nomor_hp"]),
                        MenuItem(
                            onClick: () {},
                            title: "Golongan Darah",
                            subtitle: requestDonor[0]["fields"]
                                    ["golongan_darah"] +
                                requestDonor[0]["fields"]["rhesus"]),
                      ],
                    )
                  : const Text("NO")
            ],
          ),
        ));
  }
}
