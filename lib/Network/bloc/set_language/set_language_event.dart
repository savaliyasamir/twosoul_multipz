
import 'package:flutter/material.dart';
import 'package:twosoul_multipz/Network/model/request%20model/set_language_request_model.dart';

@immutable
abstract class SetLanguageEvents {
  const SetLanguageEvents();
}

class FetchLanguageData extends SetLanguageEvents {
 final SetLanguageRequestModel setLanguageRequestModel;
  const FetchLanguageData(
      this.setLanguageRequestModel);

  List<Object?> get props => [setLanguageRequestModel];

  @override
  String toString() => 'code: $setLanguageRequestModel}';
}
