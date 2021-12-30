// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'dart:async';

// import '../env.sample.dart';
// import '../model/tanya.dart';

import 'package:tk2_pbp/env.sample.dart';
import 'package:tk2_pbp/model/tanya.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);
  @override
  FAQState createState() {
    return FAQState();
  }
}

class FAQState extends State<FAQ> {
  final _formKey = GlobalKey<FormState>();

  Future<List<Tanya>>? nanya;
  final tanyaListKey = GlobalKey<FAQState>();

  List<Tanya> listTanya = [];

  @override
  void initState() {
    super.initState();
    nanya = getTanyaList();
  }

  Future<List<Tanya>> getTanyaList() async {
    final response = await http
        .get(Uri.parse("${Env.URL_PREFIX}/tanya/tanyadetails?format=json"));
    //print(response.body);
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Tanya> nanya = items.map<Tanya>((json) {
      return Tanya.fromJson(json);
    }).toList();
    items.forEach((pertanyaan) {
      listTanya.add(Tanya.fromJson(pertanyaan));
    });
    return nanya;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     title: Text("KonvaSearch")
        // ),
        appBar: AppBar(
          //title: 'KonvaSearch',
          title: Row(children: [
            Container(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 36.0,
                  height: 36.0,
                ),
                margin: const EdgeInsets.fromLTRB(0, 0, 4.0, 0)),
            Text("KonvaSearch",
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ]),
          backgroundColor: const Color.fromRGBO(0, 41, 84, 1),
        ),
        // body: Center(
        //   child: RaisedButton(
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //       child: Text("Go Back")
        //   ),
        // )
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 20,
          ),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            children: <Widget>[
              Text(
                'Frequently Asked Question',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: const Color.fromRGBO(0, 41, 84, 1),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              FutureBuilder<List<Tanya>>(
                future: nanya,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // By default, show a loading spinner.
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  // Render employee lists
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = snapshot.data[index];
                      return GFAccordion(
                          title: data.pertanyaan,
                          content: data.jawaban,
                          collapsedIcon: Icon(Icons.add),
                          expandedIcon: Icon(Icons.minimize)
                          //   child: ListTile(
                          //     leading: Icon(Icons.person),
                          //     title: Text(
                          //       data.ename,
                          //       style: TextStyle(fontSize: 20),
                          //     ),
                          //   ),
                          );
                    },
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Any Other Question?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: const Color.fromRGBO(0, 41, 84, 1),
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: new InputDecoration(
                            hintText: "contoh: Chika",
                            labelText: "Nama",
                            icon: Icon(Icons.people),
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                          ),
                          // The validator receives the text that the user has entered.

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mohon isi nama';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: new InputDecoration(
                            hintText:
                                "contoh: Apa persyaratan untuk mendonorkan plasma konvalesen?",
                            labelText: "Pertanyaan",
                            icon: Icon(Icons.help),
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                          ),
                          // The validator receives the text that the user has entered.
                          //bool pertanyaanAda = false;
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tolong ajukan pertanyaan';
                            }

                            for (int i = 0; i < listTanya.length; i++) {
                              //print(listTanya[i].pertanyaan);
                              if (listTanya[i].pertanyaan == value) {
                                return 'Pertanyaan sudah pernah diajukan';
                              }
                            }

                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        //padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              //_formKey.currentState.save();
                              _formKey.currentState!.save();
                              showAlertDialog(context);
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(content: Text('Processing Data')),
                              //   );
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Selamat!"),
    content: Text("Pertanyaan anda berhasil diajukan!"),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
