import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tk2_pbp/components/menu_items.dart';
import 'package:tk2_pbp/components/page_header.dart';
import 'package:tk2_pbp/helpers/authenticated_request.dart';

class RequestDonorReportForm extends StatefulWidget {
  const RequestDonorReportForm({Key? key}) : super(key: key);

  @override
  _RequestDonorReportFormState createState() => _RequestDonorReportFormState();
}

class _RequestDonorReportFormState extends State<RequestDonorReportForm> {
  CookieRequest request = CookieRequest();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        request = Provider.of<CookieRequest>(context, listen: false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Create a Support Ticket'),
          backgroundColor: const Color.fromRGBO(0, 41, 84, 1),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              const PageHeader(title: "Create a Support Ticket", subtitle: "Please fill in the details below."),

            ],
          ),
        ));
  }
}
