import 'package:flutter/material.dart';

abstract class ApplicationBar {
  static AppBar appbar(String title, Icon icon, onPressed) {
    return AppBar(
      title: Text(
        title,style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: GestureDetector(onTap: onPressed, child: icon),
    );
  }
}
