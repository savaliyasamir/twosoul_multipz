

import 'package:flutter/material.dart';
import 'package:twosoul_multipz/Network/model/request%20model/user_multi_image_request_model.dart';

@immutable
abstract class UserMultiImageEvents {
  const UserMultiImageEvents();
}

class FetchData extends UserMultiImageEvents {
  final UserMultiImageRequestModel userMultiImageRequestModel;
  const FetchData(
      this.userMultiImageRequestModel);

  List<Object?> get props => [userMultiImageRequestModel];

  @override
  String toString() => 'User Multi Image: $userMultiImageRequestModel}';
}
