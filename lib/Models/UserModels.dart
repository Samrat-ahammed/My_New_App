class UserModel {
  String? uid;
  String? fullName;
  String? email;
  String? profilPic;
  UserModel({this.uid, this.fullName, this.email, this.profilPic});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullName = map["fullName"];
    email = map["email"];
    profilPic = map["profilPic"];
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullName": fullName,
      "email": email,
      "profilPic": profilPic
    };
  }
}
