

import 'package:flutter/material.dart';

@immutable
abstract class GetCityEvents {
  const GetCityEvents();
}

class FetchCityData extends GetCityEvents {
  final String countryId;
  final String stateId;
  const FetchCityData(
      this.countryId,
      this.stateId
      );

  List<Object?> get props => [countryId,stateId];

  @override
  String toString() =>'Country Id: $countryId''State Id: $stateId';

}