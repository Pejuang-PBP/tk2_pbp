import 'package:flutter/material.dart';

class DonorBar extends StatefulWidget {
  final int donorCount;
  final int userCount;
  const DonorBar({Key? key, this.donorCount = 0, this.userCount = 0})
      : super(key: key);

  @override
  _DonorBarState createState() => _DonorBarState();
}

class _DonorBarState extends State<DonorBar> {
  double getPercentage() {
    if (widget.userCount != 0) {
      return widget.donorCount / widget.userCount;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LinearProgressIndicator(
          value: getPercentage(),
          color: const Color.fromRGBO(255, 0, 0, 1),
          backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
          minHeight: 20,
        ),
        const SizedBox(height: 5),
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: widget.donorCount.toString(),
                style: const TextStyle(
                  color: Color.fromRGBO(255, 0, 0, 1),
                  fontSize: 18,
                ),
              ),
              const TextSpan(
                text: " orang ingin mendonorkan plasmanya",
                style: TextStyle(
                  color: Color.fromRGBO(32, 59, 97, 1),
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
