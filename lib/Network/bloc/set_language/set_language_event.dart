
import 'package:flutter/material.dart';

@immutable
abstract class SetLanguageEvents {
  const SetLanguageEvents();
}

class FetchData extends SetLanguageEvents {
  final String selectedLanguage;
  const FetchData(
      this.selectedLanguage);

  List<Object?> get props => [selectedLanguage];

  @override
  String toString() => 'Selected Language: $selectedLanguage}';
}
