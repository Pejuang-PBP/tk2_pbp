import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/donor_bar.dart';
import '../widgets/recipient_bar.dart';
import '../widgets/carousel.dart';


class CountData {
  final int donorCount;
  final int recipientCount;
  final int userCount;

  CountData({
    required this.donorCount,
    required this.recipientCount,
    required this.userCount,
  });

  factory CountData.fromJson(Map<String, dynamic> json) {
    return CountData(
      donorCount: json["donor_count"],
      recipientCount: json["recipient_count"],
      userCount: json["user_count"],
    );
  }
}



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<CountData> data;
  List<Map<String, String>> carouselData = [];

  @override
  void initState() {
    super.initState();
    data = fetchCountData();
    fetchSlides();
  }

  Future<CountData> fetchCountData() async {
    final response = await http.
            get(Uri.parse("http://10.0.2.2:8000/get_count"));
            // get(Uri.parse("http://localhost:8000/get_count"));


    if (response.statusCode == 200) {
      return CountData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  Future<void> fetchSlides() async {
    final response = await http.
            get(Uri.parse("http://10.0.2.2:8000/slides-api"));
            // get(Uri.parse("http://localhost:8000/slides-api"));

    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> jsonList = jsonDecode(response.body)["data"];
        for (var e in jsonList) {
          carouselData.add(Map<String, String>.from(e));
        }
      });
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(210, 224, 239, 1),
      child: Column(
        children: <Widget>[
          Column(
            children: [
              const SizedBox( height: 10, ),
              Carousel(carouselData: carouselData,),
              const SizedBox( height: 10, ),
            ],
          ),
          const SizedBox(height: 20,),

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
                const SizedBox(height: 10,),
                FutureBuilder<CountData>(
                  future: data,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DonorBar(
                              donorCount: snapshot.data!.donorCount, 
                              userCount: snapshot.data!.userCount);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const DonorBar();
                  }
                ),
                const SizedBox(height:30),
                FutureBuilder<CountData>(
                  future: data,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return RecipientBar(
                              recipientCount: snapshot.data!.recipientCount, 
                              userCount: snapshot.data!.userCount);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const RecipientBar();
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}