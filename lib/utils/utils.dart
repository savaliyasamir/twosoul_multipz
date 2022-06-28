

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/firebase_Response_Model.dart';
import '../ui/chat/chat_room.dart';
import 'firebase_constants.dart';

Future<Map<String, dynamic>> fetchUser(
    String userId,
    String usersCollectionName) async {
  final doc = await FirebaseFirestore.instance
      .collection(usersCollectionName)
      .doc(userId)
      .get();

  final data = doc.data()??{};
  data['id'] = int.parse(doc.id);
  return data;
}



Future<List<FirebaseUserModel>> fetchAllUsers(
    String usersCollectionName) async {
  final doc = await FirebaseFirestore.instance
      .collection(usersCollectionName)
      .get();
  List<FirebaseUserModel> userData=[];
  // snapshot.data?.docs
  for (var element in doc.docs) {
    userData.add(FirebaseUserModel.fromDocument(element));
    print("object");
  }

  return userData;
}

/// Fetches user from Firebase and returns a promise
Future<Map> getUnreadMessage({required int userId,
  required String groupChatId,
  required String collectionName}) async {

  List<Map> tempValue = [];

  final doc = await FirebaseFirestore.instance
      .collection("$collectionName/$groupChatId/messages")
      .orderBy('timestamp', descending: true).get();

  doc.docs.toList().forEach((element) {
    if(element.data()["idTo"] != "admin"){
      if(element.data()["idTo"] == userId && element.data()["isRead"] == 0){
        tempValue.add(element.data());
      }
    }
  });

  ///last msg
  if(doc.docs.toList().isNotEmpty){
    return doc.docs.toList().first.data();
    ///send count with this return
  }


  return {};
}

Future<List<ChatRoom>> processRoomsQuery(
    int currentUserId,
    QuerySnapshot<Map<String, dynamic>> query,
    String usersCollectionName,
    ) async {
  final futures = query.docs.map(
        (doc) => processRoomDocument(
      doc,
      currentUserId,
      usersCollectionName,
    ),
  );

  return await Future.wait(futures);
}

Future<ChatRoom> processRoomDocument(
    DocumentSnapshot<Map<String, dynamic>> doc,
    int currentUserId,
    String usersCollectionName,
    ) async {
  final data = doc.data()!;

  if(data['createdAt']!=null){
    data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
  }
  data['id'] = doc.id;
  if(data['updatedAt']!=null){
    data['updatedAt'] = data['updatedAt']/*?.millisecondsSinceEpoch*/;
  }

  var imageUrl = "";
  var name = "";
  var userIds = [];

  if(data['imageUrl'] != null){
    imageUrl = (data['imageUrl'] as String?)!;
  }
  if(data['name'] != null){
    name = (data['name'] as String?)!;
  }


  if(data['userIds']!=null){
    userIds = data['userIds'] as List<dynamic>;
  }

  final users = await Future.wait(
    userIds.map(
          (userId) => fetchUser(
        "$userId",
        usersCollectionName,
      ),
    ),
  );

  var message = await getUnreadMessage(
      userId: currentUserId,
      groupChatId: doc.id,
      collectionName: FirestoreConstants.pathMessageCollection
  );


  Map metadata = {};
  try {
    final otherUser = users.firstWhere(
          (u) => u['id'] != currentUserId,
    );

    imageUrl = (otherUser['imageUrl'] as String?)!;
    name = '${otherUser['name'] ?? ''}'
        .trim();

    metadata = otherUser;

  } catch (e) {}

  if(message.isNotEmpty){
    data["lastMessage"]= message;
  }

  data["metadata"] = metadata;
  data['imageUrl'] = imageUrl;
  data['name'] = name;
  data['users'] = users;

  var user_type = [];
  if(users!=null){
    for (var element in users) {
      user_type.add(element["user_type"]);
    }
  }


  if (data['lastMessages'] != null) {
    final lastMessages = data['lastMessages'].map((lm) {
      final author = users.firstWhere(
            (u) => u['id'] == lm['authorId'],
        orElse: () => {'id': lm['authorId'] as String},
      );

      lm['author'] = author;
      lm['createdAt'] = lm['createdAt']?.millisecondsSinceEpoch;
      lm['id'] = lm['id'] ?? '';
      lm['updatedAt'] = lm['updatedAt']?.millisecondsSinceEpoch;

      return lm;
    }).toList();

    data['lastMessages'] = lastMessages;
  }

  return ChatRoom.fromJson(data);
}