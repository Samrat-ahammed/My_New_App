import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_new_app/Models/UserModels.dart';
import 'package:my_new_app/pages/Search_Page.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final User fireBaseUser;

  const HomePage(
      {super.key, required this.userModel, required this.fireBaseUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My App"),
        centerTitle: true,
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(
                  userModel: widget.userModel,
                  firebaseUser: widget.fireBaseUser),
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
