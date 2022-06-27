

import 'package:flutter/material.dart';
import 'package:twosoul_multipz/Network/model/request%20model/filter_data_request_model.dart';

@immutable
abstract class FilterDataEvents {
  const FilterDataEvents();
}

class FetchFilterData extends FilterDataEvents {
  final FilterDataRequestModel filterDataRequestModel;
  const FetchFilterData(
      this.filterDataRequestModel);

  List<Object?> get props => [filterDataRequestModel];

  @override
  String toString() => 'HomePage: $filterDataRequestModel';
}
