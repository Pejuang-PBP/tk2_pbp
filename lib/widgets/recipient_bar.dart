import 'package:flutter/material.dart';

class RecipientBar extends StatefulWidget {
  final int recipientCount;
  final int userCount;

  const RecipientBar({Key? key, this.recipientCount=0, this.userCount=0}) : super(key: key);

  @override
  _RecipientBarState createState() => _RecipientBarState();
}

class _RecipientBarState extends State<RecipientBar> {

  double getPercentage() {
    if (widget.userCount != 0) {
      return widget.recipientCount / widget.userCount;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LinearProgressIndicator(
          value: getPercentage(),
          color: const Color.fromRGBO(204, 23, 40, 1),
          backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
          minHeight: 20,
        ),
        const SizedBox(height: 5),
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: widget.recipientCount.toString(),
                style: const TextStyle(
                  color: Color.fromRGBO(204, 23, 40, 1),
                  fontSize: 18,
                ),
              ),
              const TextSpan(
                text: " orang sedang mencari donor plasma",
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