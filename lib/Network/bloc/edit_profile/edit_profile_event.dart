



import 'package:flutter/material.dart';
import 'package:twosoul_multipz/Network/model/request%20model/edit_profile_request_model.dart';

@immutable
abstract class EditProfileEvents {
  const EditProfileEvents();
}

class FetchEditProfileData extends EditProfileEvents {
  final EditProfileRequestModel editProfileRequestModel;
  const FetchEditProfileData(
      this.editProfileRequestModel);

  List<Object?> get props => [editProfileRequestModel];

  @override
  String toString() => 'editProfile: $editProfileRequestModel';
}
