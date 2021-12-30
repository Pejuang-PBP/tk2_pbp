// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tk2_pbp/components/page_header.dart';
import 'package:tk2_pbp/helpers/authenticated_request.dart';

class RequestDonorReportForm extends StatefulWidget {
  const RequestDonorReportForm({Key? key}) : super(key: key);

  @override
  _RequestDonorReportFormState createState() => _RequestDonorReportFormState();
}

class _RequestDonorReportFormState extends State<RequestDonorReportForm> {
  final _formKey = GlobalKey<FormState>();
  CookieRequest request = CookieRequest();
  String title = "";
  String message = "";

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
        body: Form(
            key: _formKey,
            child: Center(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  const PageHeader(
                      title: "Create a Support Ticket",
                      subtitle: "Please fill in the details below."),
                  Container(
                    margin: EdgeInsets.only(bottom: 25),
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (String? value) {
                        if (value != null) {
                          title = value;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Title",
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1.0)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Wajib diisi";
                        }
                        setState(() {
                          title = value;
                        });
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 25),
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (String? value) {
                        if (value != null) {
                          setState(() {
                            message = value;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Message",
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1.0)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Wajib diisi";
                        }
                        setState(() {
                          message = value;
                        });
                        return null;
                      },
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final response = await request.post(
                                  "https://tk1-pbp.herokuapp.com/dashboard-donor/api/report",
                                  {
                                    "title": title,
                                    "message": message,
                                  });

                              if (response["status"] == true) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      "Successfully Created Support Ticket"),
                                ));
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: Text("Submit")))
                ],
              ),
            )));
  }
}
