
import 'package:flutter/material.dart';
import 'package:twosoul_multipz/Network/model/request%20model/accept_reject_request_model.dart';

@immutable
abstract class AcceptRejectEvents {
  const AcceptRejectEvents();
}

class FetchAcceptRejectData extends AcceptRejectEvents {
  final AcceptRejectRequestModel acceptRejectRequestModel;
  const FetchAcceptRejectData(
      this.acceptRejectRequestModel);

  List<Object?> get props => [acceptRejectRequestModel];

  @override
  String toString() => 'Accept Reject Friend Request: $acceptRejectRequestModel';
}


