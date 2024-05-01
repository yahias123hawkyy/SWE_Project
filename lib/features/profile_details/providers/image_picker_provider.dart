import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier {
  File? _imageFile;
  final ImagePicker _imagePicker = ImagePicker();

  File? get imageFile =>_imageFile;

   Future<File?> addImagetoProfile(ImageSource source) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source);

      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    } catch (err) {
      print("error:  $err");
    }

    notifyListeners();
    return _imageFile;
  }
}
