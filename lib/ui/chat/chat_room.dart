
import 'package:twosoul_multipz/Network/model/response%20model/common_model/user_data_model.dart';

import '../../../ui/chat/message_chat.dart';
class ChatRoom {
  /// Created room timestamp, in ms
  final int? createdAt;

  /// Room's unique ID
  final String? id;

  /// Room's image. In case of the [RoomType.direct] - avatar of the second person,
  /// otherwise a custom image [RoomType.group].
  final String? profilePhoto;

  /// List of last messages this room has received
  final MessageChat? lastMessages;

  /// Room's name. In case of the [RoomType.direct] - name of the second person,
  /// otherwise a custom name [RoomType.group].
  final String? name;

  /// Updated room timestamp, in ms
  final int? updatedAt;

  /// List of users which are in the room
  final List<UserData>? users;

  ChatRoom({
    this.createdAt, this.id, this.profilePhoto, this.lastMessages,
    this.name, this.updatedAt, this.users
  });


  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
    id: json["id"],
    name: json["name"],
    profilePhoto: json["profilePhoto"]??"",
    createdAt: json["createdAt"],
    lastMessages: json["lastMessage"]!=null ? MessageChat.fromJson(json: json["lastMessage"]):null,
    updatedAt: json["updatedAt"],
    users: json["users"]!=null?List<UserData>.from(json["users"].map((x) => UserData.fromJson(x))):[],

  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profilePhoto": profilePhoto,
    "createdAt": createdAt,
    "lastMessages": lastMessages,
    "updatedAt": updatedAt,
    "users": users,
  };

}
