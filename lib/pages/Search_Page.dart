// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_new_app/Models/CreatRoomModel.dart';
import 'package:my_new_app/Models/UserModels.dart';
import 'package:my_new_app/main.dart';
import 'package:my_new_app/pages/chatsRoomPage.dart';

class SearchPage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const SearchPage(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<ChatRoomModel?> getChatRoomModel(UserModel targetUser) async {
    ChatRoomModel? chatroom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatroom")
        .where("perticipants.${widget.userModel.uid}", isEqualTo: true)
        .where("perticipants.${targetUser.uid}", isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatRoom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatroom = existingChatRoom;
      //Fetch The exgesting onjm

      log("Chats Room Already created");
    } else {
      //create room
      ChatRoomModel newChatroom =
          ChatRoomModel(chatRoomId: uuid.v1(), lastMassege: "", perticipants: {
        widget.userModel.uid.toString(): true,
        targetUser.uid.toString(): true,
      });
      await FirebaseFirestore.instance
          .collection("chatroom")
          .doc(newChatroom.chatRoomId)
          .set(newChatroom.toMap());
      chatroom = newChatroom;

      log("Chats Room  created");
    }
    return chatroom;
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                  labelText: "Email Address", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              child: const Text("Search"),
              onPressed: () {
                setState(() {});
              },
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("user")
                  .where("email", isEqualTo: searchController.text)
                  .where("email", isNotEqualTo: widget.userModel.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;
                    if (dataSnapshot.docs.length > 0) {
                      Map<String, dynamic> userMap =
                          dataSnapshot.docs[0].data() as Map<String, dynamic>;

                      UserModel searchUser = UserModel.fromMap(userMap);

                      return ListTile(
                        onTap: () async {
                          ChatRoomModel? chatroomModel =
                              await getChatRoomModel(searchUser);

                          if (chatroomModel != null) {
                            Navigator.pop(context);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatRoomPage(
                                  targetUser: searchUser,
                                  userModel: widget.userModel,
                                  firebaseUser: widget.firebaseUser,
                                  chatroom: chatroomModel,
                                ),
                              ),
                            );
                          }
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(searchUser.profilPic!),
                          backgroundColor: Colors.grey[500],
                        ),
                        title: Text(searchUser.fullName!),
                        subtitle: Text(searchUser.email!),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                      );
                    } else {
                      return const Text("no result found");
                    }
                  } else if (snapshot.hasError) {
                    return const Text("an error ocqured");
                  } else {
                    return const Text("No ruselt found");
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
