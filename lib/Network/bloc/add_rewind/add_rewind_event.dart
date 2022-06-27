

import 'package:flutter/material.dart';
import 'package:twosoul_multipz/Network/model/request%20model/sned_type_request_model.dart';

@immutable
abstract class AddRewindEvents {
  const AddRewindEvents();
}

class FetchAddRewindData extends AddRewindEvents {
   final AddRewindRequestModel sendTypeRequestModel;
  const FetchAddRewindData(
      this.sendTypeRequestModel);

  List<Object?> get props => [sendTypeRequestModel];

  @override
  String toString() => 'receiverId: $sendTypeRequestModel';
}
