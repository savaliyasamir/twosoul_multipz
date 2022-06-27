


import 'package:flutter/material.dart';

@immutable
abstract class SnoozeEvents {
  const SnoozeEvents();
}

class FetchData extends SnoozeEvents {
  final String invisible_type;
  const FetchData(
      this.invisible_type,
      );

  List<Object?> get props => [invisible_type
  ];

  @override
  String toString() =>'invisible_type: $invisible_type';

}