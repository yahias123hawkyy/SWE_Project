import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  OnboardingPage(
      {required this.title, required this.description, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          SizedBox(height: 30.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontFamily: "Inter",
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xFFA6A6A6)
            ),
          ),
        ],
      ),
    );
  }
}

