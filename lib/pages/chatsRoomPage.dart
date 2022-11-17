import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_new_app/Models/MessageModel.dart';
import 'package:my_new_app/Models/UserModels.dart';
import 'package:my_new_app/main.dart';

import '../Models/CreatRoomModel.dart';

class ChatRoomPage extends StatefulWidget {
  final UserModel targetUser;

  final ChatRoomModel chatroom;
  final UserModel userModel;
  final User firebaseUser;

  const ChatRoomPage(
      {super.key,
      required this.targetUser,
      required this.chatroom,
      required this.userModel,
      required this.firebaseUser});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  TextEditingController messageController = TextEditingController();
  void sendMessage() async {
    String msg = messageController.text.trim();
    messageController.clear();

    if (msg != "") {
      //Send sms
      MessageModel newMassage = MessageModel(
          messageid: uuid.v1(),
          sender: widget.userModel.uid,
          createdon: DateTime.now(),
          text: msg,
          seen: false);
      FirebaseFirestore.instance
          .collection("chatroom")
          .doc(widget.chatroom.chatRoomId)
          .collection("message")
          .doc(newMassage.messageid)
          .set(newMassage.toMap());
      log("message send");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage:
                  NetworkImage(widget.targetUser.profilPic.toString()),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.targetUser.fullName.toString())
          ],
        ),
      ),
      body: Column(
        children: [
          // This is where the chats will go
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chatroom")
                    .doc(widget.chatroom.chatRoomId)
                    .collection("message")
                    .orderBy(
                      "createdon",
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot dataSnapshot =
                          snapshot.data as QuerySnapshot;

                      return ListView.builder(
                        reverse: true,
                        itemCount: dataSnapshot.docs.length,
                        itemBuilder: (context, index) {
                          MessageModel currentMessage = MessageModel.fromMap(
                              dataSnapshot.docs[index].data()
                                  as Map<String, dynamic>);

                          return Text(currentMessage.text.toString());
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            "An error occured! Please check your internet connection."),
                      );
                    } else {
                      return const Center(
                        child: Text("Say hi to your new friend"),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            color: Colors.grey[200],
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    maxLines: null,
                    controller: messageController,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Enter message"),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    sendMessage();
                  },
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
