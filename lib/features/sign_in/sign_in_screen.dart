import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/main_screen/views/main_screen.dart';
import 'package:iparkmobileapplication/features/payment_history_screen/views/payment_card.dart';
import 'package:iparkmobileapplication/features/sign_in/helpers.dart';
import 'package:iparkmobileapplication/features/sign_in/sign_up_screen.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
import 'package:iparkmobileapplication/utils/themes/buttons_styles.dart'
    as buttons;
import 'package:iparkmobileapplication/utils/themes/form_styles.dart';

class SignInScreen extends StatefulWidget {
  static const String nameRoute = "Login_screen";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: ApplicationBar.appbar("", Icon(null), null),
      body: SingleChildScrollView(
        child: Container(
          // height: screenSize.height *0.6,
          margin: EdgeInsets.all(screenSize.width * 0.1),
          alignment: Alignment.topCenter,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stre,
            children: [
              Text(
                "Sign In",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Text("Enter your Email and Password "),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _email = value;
                            });
                          },
                          validator: (value) => Helper.returnMessage(value),
                          decoration:
                              FormStyles.formStyle.copyWith(labelText: "Email")),
                      SizedBox(height: screenSize.height*0.02),
                      TextFormField(
                          onChanged: (value) {
                            setState(() {
                             _password = value;
                            });
                          },
                          validator: (value) => Helper.validatePassword(value),
                          obscureText: true,
                          decoration: FormStyles.formStylePassword),
                      SizedBox(height: screenSize.height * 0.05),
                      ElevatedButton(
                        onPressed: ()=>Helper.validateOnClick(_formKey,context),
                        child: Text("Sign In",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        style: buttons.signInELevatedButtonstyle(context),
                      )
                    ],
                  )),

              SizedBox(height: screenSize.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don'y have an account yet?"),
                  Container(
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: null,
                          ),
                          onPressed: () => Navigator.pushNamed(
                              context, SignUpScren.nameRoute),
                          child: Text(
                            "Sign Up now",
                            style: TextStyle(
                                color: MainColors.mainLightThemeColor),
                          ))),
                ],
              ),

              // SizedBox(width: 16.0),

              Text(
                "You can also sign in with:",
                style: TextStyle(fontSize: 14),
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


