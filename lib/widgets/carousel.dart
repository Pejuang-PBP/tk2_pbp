import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:tk2_pbp/widgets/transparent_modal.dart';

// final List<String> carouselData = [
//   "Apa itu konvalesen?",
//   "Bagaimana cara kerjanya?",
// ];

class Carousel extends StatelessWidget {
  const Carousel({Key? key, required this.carouselData}) : super(key: key);

  final List<Map<String, String>> carouselData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        items: carouselData.map<Widget>((item) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(opaque: false, pageBuilder: (BuildContext context, _, __) => TransparentModalScreen(header: item["header"]!, desc: item["desc"]!)));
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        item["header"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          color: Color.fromRGBO(32, 59, 97, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Color.fromRGBO(32, 59, 97, 1),
                        height: 15,
                        thickness: 1,
                        indent: 50,
                        endIndent: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
