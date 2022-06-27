


import 'package:flutter/material.dart';
import 'package:twosoul_multipz/Network/model/request%20model/send_match_friend_request_model.dart';

@immutable
abstract class SendMatchFriendEvents {
  const SendMatchFriendEvents();
}

class FetchSendMatchData extends SendMatchFriendEvents {
  final SendMatchFriendRequestModel sendMatchFriendRequestModel;
  const FetchSendMatchData(
      this.sendMatchFriendRequestModel);

  List<Object?> get props => [sendMatchFriendRequestModel];

  @override
  String toString() => 'send match friend: $sendMatchFriendRequestModel';
}
