import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUpload {
  uploadProfileImage() async {
    final storage = FirebaseStorage.instance;
    final picker = ImagePicker();

    XFile image;

    //check
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //select image
      image = (await picker.pickImage(source: ImageSource.gallery))!;
      File file = File(image.path);

      if (image != null) {
        //uplod
        var uploadTask = await storage
            .ref()
            .child('userImage/${FirebaseAuth.instance.currentUser!.uid}')
            .putFile(file);
        String url = await (await uploadTask).ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'pic_url': url});
      } else {
        print("No Image");
      }
    } else {
      print("permission error..............");
    }
  }

  uploadCoverImage() async {
    final storage = FirebaseStorage.instance;
    final picker = ImagePicker();

    XFile image;

    //check
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //select image
      image = (await picker.pickImage(source: ImageSource.gallery))!;
      File file = File(image.path);

      if (image != null) {
        //uplod
        var uploadTask = await storage
            .ref()
            .child('coverImage/${FirebaseAuth.instance.currentUser!.uid}')
            .putFile(file);
        String url = await (await uploadTask).ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'cover_url': url});
      } else {
        print("No Image");
      }
    } else {
      print("permission error..............");
    }
  }
}
