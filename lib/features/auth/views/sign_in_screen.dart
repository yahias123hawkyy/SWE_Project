import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/main_screen/views/main_screen.dart';
import 'package:iparkmobileapplication/features/payment_history/views/payment_card.dart';
import 'package:iparkmobileapplication/features/auth/handlers_and_providers/helpers.dart';
import 'package:iparkmobileapplication/features/auth/views/sign_up_screen.dart';
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
  String username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: ApplicationBar.appbar("", const Icon(null), null),
      body: SingleChildScrollView(
        child: Container(
          // height: screenSize.height *0.6,
          margin: EdgeInsets.all(screenSize.width * 0.1),
          alignment: Alignment.topCenter,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stre,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              const Text("Enter your username and Password "),
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
                              username = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.length < 5) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                          decoration: FormStyles.formStyle
                              .copyWith(labelText: "username")),
                      SizedBox(height: screenSize.height * 0.02),
                      TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.length < 8) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: FormStyles.formStylePassword),
                      SizedBox(height: screenSize.height * 0.05),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final auth = AuthenticationService();
                            bool success =
                                await auth.signIn(username, _password);

                            if (success) {
                              Navigator.pushNamed(
                                  context, MainScreenView.routeName);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                // ignore: prefer_const_constructors
                                SnackBar(
                                    content: const Text(
                                        ' sorry there was an error doing this operation')),
                              );
                            }
                          }
                        },
                        child: const Text("Sign In",
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
                  const Text(
                    "Don't have an account yet?",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Expanded(
                    child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: null,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, SignUpScren.nameRoute),
                        child: Text(
                          "Sign Up now",
                          style:
                              TextStyle(color: MainColors.mainLightThemeColor),
                        )),
                  ),
                ],
              ),

              // SizedBox(width: 16.0),

              const Text(
                "You can also sign in with:",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: screenSize.height * 0.05),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Expanded(
              //         child: InkWell(
              //       onTap: () {
              //         // Handle the click action here
              //         print('Image Clicked!');
              //       },
              //       child: Image.asset(
              //         'assets/images/google.png',
              //         width: screenSize.width * 0.02, // Set the desired width
              //         height: screenSize.height * 0.06,
              //         fit: BoxFit.contain, // Set the desired height
              //       ),
              //     )),
              //     Expanded(
              //         child: InkWell(
              //       onTap: () {
              //         // Handle the click action here
              //         print('Image Clicked!');
              //       },
              //       child: Image.asset(
              //         'assets/images/fb.png',
              //         width: screenSize.width * 0.01, // Set the desired width
              //         height: screenSize.height * 0.06,
              //         fit: BoxFit.contain, // Set the desired height
              //       ),
              //     )),
              //     Expanded(
              //         child: InkWell(
              //       onTap: () {
              //         // Handle the click action here
              //         print('Image Clicked!');
              //       },
              //       child: Image.asset(
              //         'assets/images/google.png',
              //         width: screenSize.width * 0.02, // Set the desired width
              //         height: screenSize.height * 0.06,
              //         fit: BoxFit.contain, // Set the desired height
              //       ),
              //     )),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
