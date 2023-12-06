import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iparkmobileapplication/common/widgets/app_bar.dart';
import 'package:iparkmobileapplication/features/profile_details_screens/models/my_profile.dart';
import 'package:iparkmobileapplication/features/profile_details_screens/providers/image_picker_provider.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  static const list = ["first name", "Last Name", "Email", "username"];

  static const String nameRoute = "profile_details_screen";

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
                            height:  mediaQuery.width * 0.4,
                              fit: BoxFit.cover, provider.imageFile!),
                    ),
                  ));
            },
          ),
          Expanded(
            child: ListView.builder(
                itemCount: DummyMYprofile.list.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.all(mediaQuery.width * 0.05),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: ListTile(
                          leading: Text(
                            list[index],
                            style: textStyle,
                          ),
                          title: Text(
                            DummyMYprofile.list[index].email,
                            style: textStyle,
                          )));
                }),
          ),
        ],
      ),
    );
  }
}

TextStyle textStyle =
    TextStyle(fontSize: 18, color: MainColors.mainLightThemeColor);
