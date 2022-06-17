

import 'package:flutter/material.dart';

@immutable
abstract class GetStateEvents {
  const GetStateEvents();
}

class FetchData extends GetStateEvents {
  final String countryId;
  const FetchData(
      this.countryId);

  List<Object?> get props => [countryId];

  @override
  String toString() => 'Country Id: $countryId';
}