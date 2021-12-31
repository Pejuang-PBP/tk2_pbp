import 'package:flutter/material.dart';
import 'package:tk2_pbp/styles/styles.dart';

class PageHeader extends StatelessWidget {
  const PageHeader(
      {Key? key, required this.title, required this.subtitle, this.child})
      : super(key: key);
  final String title;
  final String subtitle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2.0,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Padding(
              child: Column(children: [
                ListTile(
                    title: Container(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: Text(title, style: TextStyles.titleStyle)),
                    subtitle: Text(
                      subtitle,
                      style: TextStyles.subtitleStyle,
                    )),
                child ?? Container()
              ]),
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0))
        ]));
  }
}
