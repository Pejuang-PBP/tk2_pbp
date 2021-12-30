// ignore_for_file: camel_case_types, file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tk2_pbp/models/utd.dart';

class lokasiUtd extends StatefulWidget {
  const lokasiUtd({Key? key}) : super(key: key);

  @override
  lokasiUtdState createState() => lokasiUtdState();
}

class lokasiUtdState extends State<lokasiUtd> {
  // ignore: non_constant_identifier_names
  List<UTD> UTDs = [];
  List<UTD> filteredUTDs = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    const url = 'http://127.0.0.1:8000/lokasi-donor/json';

    final response = await http.get(Uri.parse(url));
    //print(response.body);
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    items.forEach((element) {
      UTDs.add(UTD.fromMap(element));
    });

    filteredUTDs = UTDs;

    setState(() {});
  }

  void _filterUTDs(value) {
    filteredUTDs = UTDs.where((element) => element.kota == value).toList();
  }

  bool isVisible = false;
  String inputFilter = "";
  String s =
      "UTD\n\nUnit Transfusi Darah (UTD) adalah salah satu unit kerja yang ada di PMI yang memfasilitasi pelayanan kesehatan yang menyelenggarakan donor darah, penyediaan darah, dan pendistribusian darah. Tugas dan fungsi utamanya ialah meningkatkan derajat kesehatan melalui pengelolaan darah yang berkualitas, mewujudkan pelayanan penyediaan darah yang aman, tepat waktu, terjangkau dan berkesinambungan. Para pendonor dipersilakan untuk melakukan tahapan-tahapan berikut secara berurut di salah satu UTD yang tersedia:\n1. Tahap registrasi\n2. Tahap Pemeriksaan Pendahuluan\n3. Tahap Pemeriksaan Kesehatan oleh Dokter\n4. Tahap Pengambilan Darah Donor\n5. Tahap Administrasi\n";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("lokasiUtd",
                  style: TextStyle(color: Colors.white)),
            ),
            body: ListView(children: [
              Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        child: const Text("Apa itu UTD?",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white)),
                      )),
                  Visibility(
                    visible: isVisible,
                    child: Container(
                        padding: const EdgeInsets.all(20.0), child: Text(s)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      onChanged: (value) {
                        inputFilter = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Cari kota",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (inputFilter == "") {
                                fetchData();
                              }
                              _filterUTDs(inputFilter);
                            });
                          },
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Flexible(
                          child: DataTable(
                        columns: const [
                          DataColumn(
                              label: Text('Nama',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Kota',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Alamat',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Jam Operasi',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Kontak',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                        ],
                        rows: filteredUTDs
                            .map((e) => DataRow(cells: <DataCell>[
                                  DataCell(Text(e.nama)),
                                  DataCell(Text(e.kota)),
                                  DataCell(Text(e.alamat)),
                                  DataCell(Text(e.jamOperasi)),
                                  DataCell(
                                    Text(e.nomorTelepon.toString()),
                                  )
                                ]))
                            .toList(),
                      )))
                ],
              ),
            ])));
  }
}
