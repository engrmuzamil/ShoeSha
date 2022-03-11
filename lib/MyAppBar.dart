import 'package:flutter/material.dart';
import 'package:sellshoes/constants.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.black,
        title: Row(children: [
          Expanded(flex: 1, child: Image.asset("assets/logo.png", height: 40)),
          Expanded(
            flex: 5,
            child: Text("${title}", style: constants2.heading2),
          ),
        ]));
  }

  Size get preferredSize => Size.fromHeight(56);
}
