import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_new_app/Models/FirebaseHelper.dart';
import 'package:my_new_app/Models/UserModels.dart';
import 'package:my_new_app/firebase_options.dart';
import 'package:my_new_app/pages/ComplitProfile.dart';
import 'package:my_new_app/pages/HomePage.dart';
import 'package:my_new_app/pages/LoginPage.dart';
import 'package:my_new_app/pages/SignUpPage.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    // Log in
    UserModel? thisUserModel =
        await FirebaseHelper.getUserModelByid(currentUser.uid);
    if (thisUserModel != null) {
      runApp(
        MyAppLogdin(
          userModel: thisUserModel,
          firebaseUser: currentUser,
        ),
      );
    } else {
      runApp(const MyApp());
    }
  } else {
    runApp(const MyApp());
    //not login
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class MyAppLogdin extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  const MyAppLogdin(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(userModel: userModel, fireBaseUser: firebaseUser),
    );
  }
}
