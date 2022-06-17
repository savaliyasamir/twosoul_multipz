

import 'package:flutter/material.dart';
import 'package:twosoul_multipz/Network/model/request%20model/create_profile_request_model.dart';

@immutable
abstract class CreateProfileEvents {
  const CreateProfileEvents();
}

class FetchCreateProfileData extends CreateProfileEvents {
  final CreateProfileRequestModel createProfileRequestModel;
  const FetchCreateProfileData(
      this.createProfileRequestModel);

  List<Object?> get props => [createProfileRequestModel];

  @override
  String toString() => 'create profile: $createProfileRequestModel';
}
