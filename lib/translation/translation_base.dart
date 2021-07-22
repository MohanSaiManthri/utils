import 'translation.dart';

abstract class Translation {
  /// If json is null then load the json file from path before using this fn.
  ///
  /// ``` dart
  /// Translate.loadJsonFromPath(jsonPath);
  /// ```
  ///
  /// You can use [LanguageDictionary] if you're not sure about lang code. Eg:
  /// ``` dart
  /// LanguageDictionary.English;
  ///  ```
  Future<Map<String, String>> usingGoogle(
    String from,
    String to, [
    Map<String, dynamic>? json,
  ]);

  /// Place your json in assets folder and define it in pubspec.
  /// ...
  Future<void> loadJsonFromPath(String path);
}
