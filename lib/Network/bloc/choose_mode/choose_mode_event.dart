



  import 'package:flutter/material.dart';

  @immutable
  abstract class ChooseModeEvents {
    const ChooseModeEvents();
  }

  class FetchData extends ChooseModeEvents {
    final String looking_for;
    const FetchData(
        this.looking_for,
        );

    List<Object?> get props => [        looking_for
    ];

    @override
    String toString() =>'looking_for: $looking_for';

  }