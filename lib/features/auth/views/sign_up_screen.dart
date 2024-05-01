import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/main_screen/views/main_screen.dart';
import 'package:iparkmobileapplication/features/auth/handlers_and_providers/helpers.dart';
import 'package:iparkmobileapplication/features/auth/views/sign_in_screen.dart';
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
  String firstName = "";
  String lastName = "";
  String confirmedPassword = "";

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: ApplicationBar.appbar("", const Icon(null), null),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(screenSize.width * 0.1),
          alignment: Alignment.topCenter,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30),
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                const Text("Enter your info please ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14)),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                TextFormField(
                    onChanged: (value) => _username = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      if (value.length < 5 || value.isEmpty) {
                        return 'Please enter not less than 5 letters username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Username",
                      labelStyle:
                          TextStyle(color: MainColors.mainLightThemeColor),
                      // focusedBorder: OutlineInputBorder(
                      //     borderSide:
                      //         BorderSide(color: MainColors.mainLightThemeColor)),
                    )),

                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                TextFormField(
                  onChanged: (value) => firstName = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a first Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: MainColors.mainLightThemeColor)),
                    labelText: 'First Name',
                    labelStyle:
                        TextStyle(color: MainColors.mainLightThemeColor),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                TextFormField(
                  onChanged: (value) => lastName = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Last name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: MainColors.mainLightThemeColor)),
                    labelText: 'Last Name',
                    labelStyle:
                        TextStyle(color: MainColors.mainLightThemeColor),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (value) => _password = value,
                  validator: (value) {
                    if (value == null ||
                        value.length < 8 ||
                        value.contains(firstName) ||
                        value.contains(lastName)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: MainColors.mainLightThemeColor)),
                    labelText: 'password',
                    labelStyle:
                        TextStyle(color: MainColors.mainLightThemeColor),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                TextFormField(
                  onChanged: (value) => confirmedPassword = value,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Please enter a password';
                    } else if (confirmedPassword != _password) {
                      return "please enter the confirmed password correctly";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: MainColors.mainLightThemeColor)),
                    labelText: 'confirm Password',
                    labelStyle:
                        TextStyle(color: MainColors.mainLightThemeColor),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),

                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      AuthenticationService auth = AuthenticationService();
                      final success = await auth.signUp(
                          username: _username,
                          password: _password,
                          firstName: firstName,
                          lastName: lastName);

                      print(success);
                      if (success) {
                        Navigator.pushNamed(context, MainScreenView.routeName);
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MainColors.mainLightThemeColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      fixedSize: Size.fromWidth(
                          MediaQuery.of(context).size.width * 0.8)),
                  child: const Text("Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                SizedBox(height: screenSize.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "You already have an acount?",
                      style: bodyStyle,
                    ),
                    Container(
                        child: TextButton(
                            style: const ButtonStyle(
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

                // const Text(
                //   "You can also sign up with:",
                //   style: bodyStyle,
                // ),
                // SizedBox(height: screenSize.height * 0.05),

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
      ),
    );
  }
}

const bodyStyle =
    TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold);
