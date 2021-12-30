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

    @override
    void initState() {
        super.initState();
        nanya = getTanyaList();
    }

    Future<List<Tanya>> getTanyaList() async {
        final response = await http.get(Uri.parse("${Env.URL_PREFIX}/tanya/tanyadetails?format=json"));
        print(response.body);
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Tanya> nanya = items.map<Tanya>((json) {
        return Tanya.fromJson(json);
        }).toList();

        return nanya;
    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        margin: EdgeInsets.only(left: 10, right: 10, top: 20, ),
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
            GFAccordion(
                title: 'GF Accordion 1',
                content: 'GetFlutter is an open source library that comes with  pre-build 1000+ UI components.',
                collapsedIcon: Icon(Icons.add),
                expandedIcon: Icon(Icons.minimize)
            ),
            GFAccordion(
                title: 'GF Accordion 2',
                content: 'GetFlutter is an open source library that comes with  pre-build 1000+ UI components.',
                collapsedIcon: Icon(Icons.add),
                expandedIcon: Icon(Icons.minimize)
            ),
            GFAccordion(
                title: 'GF Accordion 3',
                content: 'GetFlutter is an open source library that comes with  pre-build 1000+ UI components.',
                collapsedIcon: Icon(Icons.add),
                expandedIcon: Icon(Icons.minimize)
            ),
            GFAccordion(
                title: 'GF Accordion 4',
                content: 'GetFlutter is an open source library that comes with  pre-build 1000+ UI components.',
                collapsedIcon: Icon(Icons.add),
                expandedIcon: Icon(Icons.minimize)
            ),
            GFAccordion(
                title: 'GF Accordion 5',
                content: 'GetFlutter is an open source library that comes with  pre-build 1000+ UI components.',
                collapsedIcon: Icon(Icons.add),
                expandedIcon: Icon(Icons.minimize)
            ),
            GFAccordion(
                title: 'GF Accordion 6',
                content: 'GetFlutter is an open source library that comes with  pre-build 1000+ UI components.',
                collapsedIcon: Icon(Icons.add),
                expandedIcon: Icon(Icons.minimize)
            ),
            FutureBuilder<List<Tanya>>(
            future: nanya,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
            // By default, show a loading spinner.
            if (!snapshot.hasData) return CircularProgressIndicator();
            // Render employee lists
            return ListView.builder(
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
                    hintText: "contoh: Apa persyaratan untuk mendonorkan plasma konvalesen?",
                    labelText: "Pertanyaan",
                    icon: Icon(Icons.help),
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                ),
            // The validator receives the text that the user has entered.

                validator: (value) {
                if (value == null || value.isEmpty) {
                    return 'Tolong ajukan pertanyaan';
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
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
        )
    );
  }
}