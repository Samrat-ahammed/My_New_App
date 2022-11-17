// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_new_app/Models/UserModels.dart';
import 'package:my_new_app/pages/HomePage.dart';

class CompleteProfil extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const CompleteProfil(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<CompleteProfil> createState() => _CompleteProfilState();
}

class _CompleteProfilState extends State<CompleteProfil> {
  File? imageFile;
  TextEditingController fullNameController = TextEditingController();

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 20);
    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  void showPhotoOpttion() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Uplod Profile Picture"),
          // ignore: prefer_const_literals_to_create_immutables
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
              onTap: () {
                Navigator.pop(context);
                selectImage(ImageSource.gallery);
              },
              title: Text("Select Photo"),
              leading: Icon(Icons.photo_album),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                selectImage(ImageSource.camera);
              },
              leading: Icon(Icons.camera_alt),
              title: Text("Take a Photo"),
            ),
          ]),
        );
      },
    );
  }

  void chackValues() {
    String fullName = fullNameController.text.trim();

    if (fullName == "" || imageFile == "") {
      log("Please fill the all blanks");
    } else {
      log("Uploding deta ......");
      uploadData();
    }
  }

  void uploadData() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref("profillPic")
        .child(widget.userModel.uid.toString())
        .putFile(imageFile!);

    TaskSnapshot snapshot = await uploadTask;

    String? imageUrl = await snapshot.ref.getDownloadURL();
    String? fullname = fullNameController.text.trim();

    widget.userModel.fullName = fullname;
    widget.userModel.profilPic = imageUrl;

    await FirebaseFirestore.instance
        .collection("user")
        .doc(widget.userModel.uid)
        .set(widget.userModel.toMap())
        .then((value) {
      log("Data uploaded!");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return HomePage(
            userModel: widget.userModel,
            fireBaseUser: widget.firebaseUser,
          );
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Complete Profile"),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              onPressed: () {
                showPhotoOpttion();
              },
              padding: EdgeInsets.all(0),
              child: CircleAvatar(
                radius: 60,
                backgroundImage:
                    (imageFile != null) ? FileImage(imageFile!) : null,
                child: (imageFile == null)
                    ? Icon(
                        Icons.person,
                        size: 60,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(
                  labelText: "Full Name", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              onPressed: () {
                chackValues();
              },
              color: Theme.of(context).colorScheme.secondary,
              child: const Text(
                "Submit",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
