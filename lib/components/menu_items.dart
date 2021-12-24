library menu_items;

import 'package:flutter/material.dart';
import 'package:tk2_pbp/styles/styles.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {Key? key,
      this.icon,
      required this.title,
      required this.subtitle,
      required this.onClick})
      : super(key: key);
  final Icon? icon;
  final String title;
  final String subtitle;
  final Function() onClick;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.white,
        child: InkWell(
            borderRadius: BorderRadius.circular(8),
            splashFactory: InkRipple.splashFactory,
            splashColor: Colors.blue.shade100,
            hoverColor: Colors.grey[200],
            onTap: onClick,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Padding(
                  child: ListTile(
                    leading: icon,
                    title: Text(title, style: TextStyles.menuItem),
                    subtitle: Container(
                      child: Text(
                        subtitle,
                        style: TextStyles.subtitleStyle,
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 4.0, 0, 0),
                    ),
                    mouseCursor: SystemMouseCursors.click,
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 8.0))
            ])),
      ),
    );
  }
}
