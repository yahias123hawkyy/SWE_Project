import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/profile_details_screens/providers/image_picker_provider.dart';
import 'package:iparkmobileapplication/features/sign_in/helpers.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  static const list = ["first name", "Last Name", "Email", "username"];

  static const String nameRoute = "profile_details_screen";

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final auth = AuthenticationService();
  Map userData = {};

  late final wrapperFuture;

  @override
  void initState() {
    super.initState();
    wrapperFuture = wrapper();
  }

  Future<bool> wrapper() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userData = await auth.fetchUserData(prefs.getString("userId") ?? "");
    print(userData);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    Size mediaQuery = MediaQuery.of(context).size;
    File? image;

    return Scaffold(
      appBar: ApplicationBar.appbar(
          args["title"], Icon(Icons.arrow_back), () => Navigator.pop(context)),
      body: Column(
        children: [
          Consumer<ImagePickerProvider>(
            builder: (context, provider, child) {
              return GestureDetector(
                  onTap: () async {
                    await provider.addImagetoProfile(ImageSource.gallery);
                  },
                  child: Container(
                    height: mediaQuery.height * 0.2,
                    width: mediaQuery.width * 0.4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(50%),
                      border: Border.all(color: Colors.black),
                    ),
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: provider.imageFile == null
                          ? Image.asset("assets/images/user.png",
                              width: mediaQuery.width * 0.5)
                          : Image.file(
                              width: mediaQuery.height * 0.2,
                              height: mediaQuery.width * 0.4,
                              fit: BoxFit.cover,
                              provider.imageFile!),
                    ),
                  ));
            },
          ),

          FutureBuilder<bool>(
            future: wrapperFuture,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return Expanded(
                    child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.all(mediaQuery.width * 0.05),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: ListTile(
                            leading: Text(
                              "First Name",
                              style: textStyle,
                            ),
                            title: Text(
                              userData["firstName"],
                              style: textStyle,
                            ))),
                    Container(
                        margin: EdgeInsets.all(mediaQuery.width * 0.05),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: ListTile(
                            leading: Text(
                              "Last Name",
                              style: textStyle,
                            ),
                            title: Text(
                              userData["lastName"],
                              style: textStyle,
                            ))),
                    Container(
                        margin: EdgeInsets.all(mediaQuery.width * 0.05),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: ListTile(
                            leading: Text(
                              "Username",
                              style: textStyle,
                            ),
                            title: Text(
                              userData["username"],
                              style: textStyle,
                            ))),
                  ],
                ));
              } else {
                // Handle the case where snapshot.data is null
                return Center(child: Text("No data available"));
              }
            },
          ),

          // child: ListView.builder(
          //     itemCount: userData.keys.length,
          //     itemBuilder: (context, index) {
          //       return Container(
          //           margin: EdgeInsets.all(mediaQuery.width * 0.05),
          //           decoration: BoxDecoration(
          //               border: Border.all(width: 0.5),
          //               borderRadius: BorderRadius.all(Radius.circular(12))),
          //           child: ListTile(
          //               leading: Text(
          //                 ProfileDetailsScreen.list[index],
          //                 style: textStyle,
          //               ),
          //               title: Text(
          //                 DummyMYprofile.list[index].email,
          //                 style: textStyle,
          //               )));
          //     }),
        ],
      ),
    );
  }
}

TextStyle textStyle =
    TextStyle(fontSize: 18, color: MainColors.mainLightThemeColor);
