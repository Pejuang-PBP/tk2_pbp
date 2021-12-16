import 'package:flutter/material.dart';

class TransparentModalScreen extends StatelessWidget {
  const TransparentModalScreen({ 
    Key? key, required this.header, required this.desc 
  }) : super(key: key);

  final String header;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder (
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Spacer(),
                    Text(
                      header,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 23,
                        color: Color.fromRGBO(32, 59, 97, 1),
                      ),
                    ),
                    const SizedBox( height: 10, ),
                    const Divider(
                      color: Color.fromRGBO(32, 59, 97, 1),
                      height: 15,
                      thickness: 1,
                      indent: 50,
                      endIndent: 50,
                    ),
                    const SizedBox( height: 10, ),
                    Text(
                      desc,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(32, 59, 97, 1),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}