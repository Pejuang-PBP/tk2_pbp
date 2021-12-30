import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/donor_bar.dart';
import '../widgets/recipient_bar.dart';
import '../widgets/carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, int> countData = {
    "donor": 0,
    "recipient": 0,
    "user": 0,
  };
  List<Map<String, String>> carouselData = [];

  @override
  void initState() {
    super.initState();
    fetchCountData();
    fetchSlides();
  }

  Future<void> fetchCountData() async {
    final response = await http.get(Uri.parse("http://localhost:8000/api/counts"));
    // get(Uri.parse("http://localhost:8000/api/counts"));

    if (mounted && response.statusCode == 200) {
      setState(() {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        countData["donor"] = jsonData["donor_count"]!;
        countData["recipient"] = jsonData["recipient_count"]!;
        countData["user"] = jsonData["user_count"]!;
      });
    }
  }

  Future<void> fetchSlides() async {
    final response = await http.get(Uri.parse("http://localhost:8000/api/slides"));
    // get(Uri.parse("http://localhost:8000/api/slides"));

    if (mounted) {
      if (response.statusCode == 200) {
      setState(() {
        List<dynamic> mapList = jsonDecode(response.body)["data"];
        for (var e in mapList) {
          carouselData.add(Map<String, String>.from(e));
        }
        if (carouselData.isEmpty) {
          carouselData.add({"header": "No data", "desc": "No data"});
        }
      });
    } else {
      setState(() {
        carouselData.add({"header": "No data", "desc": "No data"});
      });
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(210, 224, 239, 1),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Carousel(
            carouselData: carouselData,
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                const Text(
                  "Status saat ini",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromRGBO(32, 59, 97, 1),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DonorBar(
                  donorCount: countData["donor"]!,
                  userCount: countData["user"]!,
                ),
                const SizedBox(height: 30),
                RecipientBar(
                  recipientCount: countData["recipient"]!,
                  userCount: countData["user"]!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
