import 'package:flutter/material.dart';
import 'package:tk2_pbp/screens/form_pencari_donor.dart';

class FormPencariDonorScreen extends StatefulWidget {
  static const routeName = '/form_pencari_donor';

  const FormPencariDonorScreen({Key? key}) : super(key: key);

  @override
  _FormPencariDonorScreenState createState() => _FormPencariDonorScreenState();
}

class _FormPencariDonorScreenState extends State<FormPencariDonorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Pencari Donor"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        backgroundColor: const Color.fromRGBO(0, 41, 84, 1),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: FormPencariDonor(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
