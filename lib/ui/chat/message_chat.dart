




import 'package:cloud_firestore/cloud_firestore.dart';

class MessageChat {
  int idFrom;
  int idTo;
  int timestamp;
  String content;
  int type;

  MessageChat({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      "idFrom": idFrom,
      "idTo": idTo,
      "timestamp": timestamp,
      "content": content,
      "type": type,

    };
  }



  factory MessageChat.fromJson({required Map<String, dynamic> json}) {
    int idFrom = json["idFrom"];
    int idTo = json["idTo"];
    int timestamp = json["timestamp"];
    String content = "${json["content"]}";
    int type = json["type"];
    return MessageChat(idFrom: idFrom, idTo: idTo,
      timestamp: timestamp, content: content, type: type,
    );
  }

  factory MessageChat.fromDocument(DocumentSnapshot doc) {
    int idFrom = doc.get("idFrom");
    int idTo = doc.get("idTo");
    int timestamp = doc.get("timestamp");
    String content = "${doc.get("content")}";
    int type = doc.get("type");
    return MessageChat(idFrom: idFrom, idTo: idTo,
      timestamp: timestamp, content: content, type: type,
    );
  }

}
