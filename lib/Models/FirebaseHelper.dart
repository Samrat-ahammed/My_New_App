import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_new_app/Models/UserModels.dart';

class FirebaseHelper {
  static Future<UserModel?> getUserModelByid(String uid) async {
    UserModel? userModel;
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("user").doc(uid).get();

    if (documentSnapshot.data() != null) {
      userModel =
          UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    }
    return userModel;
  }
}
