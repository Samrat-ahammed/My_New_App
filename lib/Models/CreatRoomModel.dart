class ChatRoomModel {
  String? messageid;
  String? chatRoomId;
  Map<String, dynamic>? perticipants;
  String? lastMassege;

  ChatRoomModel({
    this.messageid,
    this.chatRoomId,
    this.perticipants,
    this.lastMassege,
  });

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatRoomId = map["chatRoomId"];
    perticipants = map["perticipants"];
    lastMassege = map["lastmassege"];
    messageid = map["messageid"];
  }
  Map<String, dynamic> toMap() {
    return {
      "chatsRoomid": chatRoomId,
      "perticipants": perticipants,
      "lastmassege": lastMassege,
      "messageid": messageid
    };
  }
}
