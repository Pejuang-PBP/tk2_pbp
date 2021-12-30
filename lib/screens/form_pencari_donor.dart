// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:tk2_pbp/helpers/authenticated_request.dart';
import 'package:provider/provider.dart';

class FormPencariDonor extends StatefulWidget {
  const FormPencariDonor({ Key? key }) : super(key: key);

  @override
  _FormPencariDonorState createState() => _FormPencariDonorState();
}

class _FormPencariDonorState extends State<FormPencariDonor> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  String? _nama;
  String? _nik;
  String? _nomorHp;
  String? _tempatLahir;
  String? _alamat;
  String? _namaRumahSakit;
  String _gender = "Laki-laki";
  List _listGender = ["Laki-laki", "Perempuan"];
  DateTime tanggal_lahir = DateTime.now();

  String _goldar = "A";
  List _listGoldar = [
    "A",
    "B",
    "AB",
    "O",
  ];

  String _rhesus = "+";
  List _listRhesus = [
    "+",
    "-",
  ];

  String _urgency = "LOW";
  List _listUrgency = [
    "LOW",
    "MEDIUM",
    "HIGH",
  ];

  Future selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1337),
    lastDate: DateTime.now());
    if (picked != null)
      setState(() {
        tanggal_lahir = picked;
        var date ="${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        dateController.text = date;
      });
  }
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(top: 35, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: TextFormField(
                onSaved: (String? value){
                  _nama = value;
                },
                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(1.0)),
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Wajib diisi";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child:TextFormField(
                onSaved: (String? value){
                    _nik = value;
                },
                decoration: InputDecoration(
                  labelText: "NIK",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1.0)),
                ),
                validator: (value){
                  if(value!.isEmpty || value.length != 16 || !RegExp(r'^[0-9]+$').hasMatch(value)) 
                      return "NIK harus terdiri dari 16 angka";
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: TextFormField(
                onSaved: (String? value) {
                  _nomorHp = value;
                },
                decoration: InputDecoration(
                  labelText: "Nomor HP",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0)),
                ),
                validator: (value) {
                  if (value!.isEmpty){
                    return "Wajib diisi";
                  } 
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)){
                    return "Mohon masukkan angka";
                  }
                  if(value.length > 12){
                    return "Maksimal 12 digit angka";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: DropdownButtonFormField(
                value: _gender,
                items: _listGender.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _gender = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Jenis Kelamin",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: TextFormField(
                onSaved: (String? value) {
                  _tempatLahir = value;
                },
                decoration: InputDecoration(
                  labelText: "Tempat Lahir",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0)),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Wajib diisi";
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: TextFormField(
                onTap: () => selectDate(context),
                readOnly: true,
                controller: dateController,
                decoration: InputDecoration(
                  labelText: "Tanggal Lahir",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0)),
                ),
                validator: (value) {
                  if (value!.isEmpty){ 
                    return "Wajib diisi";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: TextFormField(
                onSaved: (String? value) {
                  _alamat = value;
                },
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: "Alamat",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0)),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Wajib diisi";
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: DropdownButtonFormField(
                value: _goldar,
                items: _listGoldar.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _goldar= value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Golongan Darah",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: DropdownButtonFormField(
                value: _rhesus,
                items: _listRhesus.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _rhesus = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Rhesus",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: TextFormField(
                onSaved: (String? value) {
                  _namaRumahSakit = value;
                },
                decoration: InputDecoration(
                  labelText: "Nama Rumah Sakit Tempat anda dirawat",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0)),
                ),
                validator: (value) {
                  if (value!.isEmpty){ 
                    return "Wajib diisi";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: DropdownButtonFormField(
                value: _urgency,
                items: _listUrgency.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _urgency = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Urgency",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.0)),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child:RaisedButton(
                  color: Color.fromRGBO(0, 41, 84, 1), 
                  onPressed: () async{
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      final response = await request.post(
                          "http://localhost:8000/form-pencari-donor/mobile",
                          jsonEncode(<String, String>{
                              "nama": _nama!,
                              "nomor_induk": _nik!,
                              "nomor_hp": _nomorHp!,
                              "jenis_kelamin": _gender,
                              "tempat_lahir": _tempatLahir!,
                              "tanggal_lahir": tanggal_lahir.toString(),
                              "alamat": _alamat!,
                              "golongan_darah": _goldar,
                              "rhesus": _rhesus,
                              "tempat_rawat": _namaRumahSakit!,
                              "urgency": _urgency,

                          })
                      );
                      if(response["status"] == "ok"){
                          AlertDialog alert = AlertDialog(
                            title: Text('Sukses'),
                            content: Text('Request Anda telah berhasil dikirim.'),
                            actions: <Widget>[
                              TextButton(
                                // onPressed: () => Navigator.popAndPushNamed(context, "/"),
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                      else{
                          AlertDialog alert = AlertDialog(
                            title: Text('Gagal'),
                            content: Text(response["msg"]),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: Text('OK'),
                              ),
                            ],
                          );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                    }
                    else{
                      AlertDialog alert = AlertDialog(
                            title: Text('Gagal'),
                            content: Text('Periksa kembali formulir Anda.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: Text('OK'),
                              ),
                            ],
                          );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                    }
                  },
                  child: Text("Submit"),
                  textColor: Colors.white,
                )
              )
          ],
        ),
      )
    );
  }
}