import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/sign_in/sign_in_screen.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';

class SignUpScren extends StatefulWidget {
  static const String nameRoute = "SignUp_screen";

  const SignUpScren({super.key});

  @override
  State<SignUpScren> createState() => _SignUpScrenState();
}

class _SignUpScrenState extends State<SignUpScren> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: ApplicationBar.appbar("", Icon(null), null),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(screenSize.width * 0.1),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Text(
                "Sign Up",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Text("Enter your Email, Password and username "),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              TextFormField(
                  onChanged: (value) => _username = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Username",
                       labelStyle: TextStyle(color: MainColors.mainLightThemeColor),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: MainColors.mainLightThemeColor)),
                  )),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              TextFormField(
                onChanged: (value) => _password = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: MainColors.mainLightThemeColor)),
                    
                    labelText: 'Email',   labelStyle: TextStyle(color: MainColors.mainLightThemeColor),),
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              TextFormField(
                onChanged: (value) => _password = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: MainColors.mainLightThemeColor)),
                   
                    labelText: 'Password',   labelStyle: TextStyle(color: MainColors.mainLightThemeColor),),
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              TextFormField(
                onChanged: (value) => _password = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: MainColors.mainLightThemeColor)),
                    
                    labelText: 'confirm Password'  , labelStyle: TextStyle(color: MainColors.mainLightThemeColor),),
              ),
              SizedBox(height: screenSize.height * 0.05),
              ElevatedButton(
                onPressed: () => null,
                child: Text("Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: MainColors.mainLightThemeColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    fixedSize: Size.fromWidth(
                        MediaQuery.of(context).size.width * 0.8)),
              ),
              SizedBox(height: screenSize.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You already have an acount?",style: bodyStyle,),
                  Container(
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: null,
                          ),
                          onPressed: () => Navigator.pushNamed(
                              context, SignInScreen.nameRoute),
                          child: Text(
                            "Sign In now",
                            style: TextStyle(
                                color: MainColors.mainLightThemeColor),
                          ))),
                ],
              ),

              // SizedBox(width: 16.0),

              Text(
                "You can also sign up with:",
                style: bodyStyle,
              ),
              SizedBox(height: screenSize.height * 0.05),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      // Handle the click action here
                      print('Image Clicked!');
                    },
                    child: Image.asset(
                      'assets/images/google.png',
                      width: screenSize.width * 0.02, // Set the desired width
                      height: screenSize.height * 0.06,
                      fit: BoxFit.contain, // Set the desired height
                    ),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      // Handle the click action here
                      print('Image Clicked!');
                    },
                    child: Image.asset(
                      'assets/images/fb.png',
                      width: screenSize.width * 0.01, // Set the desired width
                      height: screenSize.height * 0.06,
                      fit: BoxFit.contain, // Set the desired height
                    ),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      // Handle the click action here
                      print('Image Clicked!');
                    },
                    child: Image.asset(
                      'assets/images/google.png',
                      width: screenSize.width * 0.02, // Set the desired width
                      height: screenSize.height * 0.06,
                      fit: BoxFit.contain, // Set the desired height
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


 const bodyStyle=TextStyle(fontSize: 14,fontWeight: FontWeight.bold);