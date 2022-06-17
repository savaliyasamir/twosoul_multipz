


import 'package:flutter/material.dart';
import 'package:twosoul_multipz/Network/model/request%20model/login_request.dart';

@immutable
abstract class LoginEvents {
  const LoginEvents();
}

class FetchData extends LoginEvents {
  final LoginRequestModel loginRequestModel;
  const FetchData(
      this.loginRequestModel);

  List<Object?> get props => [loginRequestModel];

  @override
  String toString() => 'LoginRequest: $loginRequestModel}';
}
