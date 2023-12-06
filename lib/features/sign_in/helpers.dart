
import 'package:flutter/widgets.dart';
import 'package:iparkmobileapplication/features/main_screen/views/main_screen.dart';

abstract class Helper{


  static bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return emailRegex.hasMatch(email);
}

static dynamic returnMessage(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  } else if (!isValidEmail(value)) {
    return 'Please enter a valid email address';
  }
  return;
}

static validatePassword(value) {
  {
    if (value == null || value.isEmpty || value.length<8) {
      return 'Please enter a valid password';
    }
    return null;
  }
}

 static validateOnClick(GlobalKey<FormState> formKey,BuildContext context,) {
  if (formKey.currentState != null && formKey.currentState!.validate()) {
    Navigator.pushNamed(context, MainScreenView.routeName);
  }
} 
}