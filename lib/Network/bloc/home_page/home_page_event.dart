

import 'package:flutter/material.dart';

import '../../model/request model/home_page_request_model.dart';


@immutable
abstract class HomePageEvents {
   const HomePageEvents();
}

class FetchHomePageData extends HomePageEvents {
  final HomePageRequestModel homePageRequestModel;
  const FetchHomePageData(
      this.homePageRequestModel);

  List<Object?> get props => [homePageRequestModel];

  @override
  String toString() => 'HomePage: $homePageRequestModel';
}
