

import 'package:flutter/material.dart';
import 'package:twosoul_multipz/Network/model/request%20model/receive_match_request_model.dart';

@immutable
abstract class ReceiveMatchEvents {
  const ReceiveMatchEvents();
}

class FetchReceiveMatchData extends ReceiveMatchEvents {
  final ReceiveMatchRequestModel receiveMatchRequestModel;
  const FetchReceiveMatchData(
      this.receiveMatchRequestModel);

  List<Object?> get props => [receiveMatchRequestModel];

  @override
  String toString() => 'type: $receiveMatchRequestModel';
}
