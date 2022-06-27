
import 'package:flutter/material.dart';
import 'package:twosoul_multipz/Network/model/request%20model/contact_us_request_model.dart';

@immutable
abstract class ContactUsEvents {
  const ContactUsEvents();
}

class FetchContactUsData extends ContactUsEvents {
  final ContactUsRequestModel contactUsRequestModel;
  const FetchContactUsData(
      this.contactUsRequestModel);

  List<Object?> get props => [contactUsRequestModel];

  @override
  String toString() => 'contact us: $contactUsRequestModel';
}
