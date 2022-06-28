import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:twosoul_multipz/Network/model/response%20model/common_model/user_data_model.dart';
import 'package:twosoul_multipz/utils/firebase_constants.dart';

import '../../utils/utils.dart';
import 'chat_room.dart';
import 'message_chat.dart';

class ChatProvider {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ChatProvider({required this.firebaseFirestore,
    required this.firebaseStorage});

  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getChatStream(String groupChatId, int limit) {
    return firebaseFirestore
        .collection(
        '${FirestoreConstants.pathMessageCollection}/$groupChatId/messages')
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  /// Creates a direct chat for 2 people. Add [metadata] for any additional
  /// custom data.
  Future<ChatRoom> createRoom({required UserData otherUser,
    required int currentUserId,
    Map<String, dynamic>? metadata}) async {


    final users = [UserData(id: currentUserId), otherUser];

    final query = await FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .where(FirestoreConstants.userIds, arrayContains: currentUserId)
        .get();

    final rooms = await processRoomsQuery(
        currentUserId, query, FirestoreConstants.pathUserCollection);

    try {
      return rooms.firstWhere((room) {

        final userIds = room.users!.map((u) => u.id);
        return userIds.contains(currentUserId) &&
            userIds.contains(otherUser.id);
      });
    } catch (e) {
      // Do nothing if room does not exist
      // Create a new room instead
    }

    //creating and adding group in rooms collection
    final room = await FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .add({
      FirestoreConstants.createdAt: FieldValue.serverTimestamp(),
      FirestoreConstants.profilePhoto: otherUser.image!.firstWhere((element) => element.isDefault == "1").imagename,
      FirestoreConstants.metadata: metadata,
      FirestoreConstants.name: otherUser.name.toString(),
      FirestoreConstants.updatedAt: DateTime.now().millisecondsSinceEpoch,
      FirestoreConstants.userIds: users.map((u) => u.id).toList(),
    });

    return ChatRoom(
      id: room.id,
      users: users,
    );
  }

  void sendMessage({
    required String content, required int type,required String groupChatId,
    required int currentUserId,required int peerId
  }) {

    MessageChat messageChat = MessageChat(
        idFrom: currentUserId,
        idTo: peerId,
        timestamp: DateTime
            .now()
            .millisecondsSinceEpoch,
        content: content,
        type: type);
    final messageMap = messageChat.toJson();

    ///to update latest time for group
    firebaseFirestore.collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId).update({ FirestoreConstants.updatedAt: DateTime
        .now()
        .millisecondsSinceEpoch});

    ///to send msg
    firebaseFirestore
        .collection(
        '${FirestoreConstants.pathMessageCollection}/$groupChatId/messages')
        .add(messageMap);

  }

  Stream<List<ChatRoom>> rooms({int currentUserId = 0, bool orderByUpdatedAt = false}) {

    final collection = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .where('userIds', arrayContains: currentUserId)
        .orderBy('updatedAt', descending: true);


    return collection.snapshots().asyncMap(
          (query) => processRoomsQuery(
        currentUserId,
        query,
        FirestoreConstants.pathUserCollection,
      ),
    );
  }

}