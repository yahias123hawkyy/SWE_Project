import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';

class SignInScreen extends StatefulWidget {
  static const String nameRoute = "Login_screen";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: ApplicationBar.appbar("", Icon(null), null),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(screenSize.width * 0.1),
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              TextFormField(
                  onChanged: (value) => _username = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: MainColors.mainLightThemeColor)),
                  )),
              SizedBox(height: 16.0),
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
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12)),
                    enabledBorder: InputBorder.none,
                    suffix: GestureDetector(
                      onTap: () => null,
                      child: Text("Forgot password? "),
                    ),
                    labelText: 'Password'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => null,
                child: Text("Sign In",style: TextStyle(
                  color: Colors.white,fontSize: 20
                )),
                style: ElevatedButton.styleFrom(
                    backgroundColor: MainColors.mainLightThemeColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    fixedSize: Size.fromWidth(
                        MediaQuery.of(context).size.width * 0.8)),
              )
              ,SizedBox(height: 16.0),
              Row(
                children: [
                  Text("Don'y have an account yet?"),
                  SizedBox(width: 16.0),
                  Text("Sign Up now")
                ],
              ),
                  SizedBox(height: 16.0),

              Text("You can also sign in with:",style: TextStyle(
                fontSize: 14
              ),),

              Row(
                children: [
                  IconButton(onPressed: ()=>"", icon: Icon(Icons.link_rounded))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
