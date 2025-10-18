

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

Future<File> pickImage() async {

  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if(image != null){
      return File(image.path);
  }
  throw Exception("No image selected");
}



Future<String> uploadImageToStorage(String uid, File imageFile) async {

  final storageRef = FirebaseStorage.instance.ref().child("user_photos/$uid.jpg");
    await storageRef.putFile(imageFile);

  final downloadUrl = await storageRef.getDownloadURL();
  return downloadUrl;
}


Future<String> uploadDefaultProfileImage(String uid) async {
  final storageRef = FirebaseStorage.instance.ref().child('user_photos/$uid.jpg');

  final byteData = await rootBundle.load('assets/images/image_profile.png');
  final bytes = byteData.buffer.asUint8List();

  await storageRef.putData(bytes, SettableMetadata(contentType: 'image/png'));

  final downloadUrl = await storageRef.getDownloadURL();

  return downloadUrl;
}