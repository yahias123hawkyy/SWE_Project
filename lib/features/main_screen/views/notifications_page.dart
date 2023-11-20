import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static String routeName = "notification_screen";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar:ApplicationBar.appbar("Notifications", Icon(Icons.arrow_back),()=>Navigator.pop(context)) ,
    );
  }
}