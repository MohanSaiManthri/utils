import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart' hide Translation;
import 'package:utils/translation/translation.dart';
import 'package:utils/translation/translation_base.dart';

class Translate extends Translation {
  Map<String, dynamic>? json;

  @override
  Future<void> loadJsonFromPath(String path) async {
    try {
      final rawData = await rootBundle.loadString(path);
      json = jsonDecode(rawData);
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<Map<String, String>> usingGoogle(
    String to, [
    String from = LanguageDictionary.Automatic,
    Map<String, dynamic>? json,
  ]) async {
    final translatedItems = <String, String>{};
    final watch = startWatch();
    json ??= this.json;
    await Future.forEach<MapEntry<String, dynamic>>(json!.entries, (e) async {
      log(elapsedTime(watch.elapsed));
      final key = e.key;
      final value = e.value.toString();
      final translatedValue = await translateValue(value, from, to);

      /// to avoid crossing the API limit per minute.
      await Future.delayed(const Duration(milliseconds: 1500));
      translatedItems.putIfAbsent(key, () => translatedValue);
    });
    stopWatch(watch);
    return translatedItems;
  }

  Future<String> translateValue(String value, String from, String to) async {
    final tranlator = GoogleTranslator();
    final s = await tranlator.translate(value, from: from, to: to);
    return s.text;
  }

  @protected
  String elapsedTime(Duration elapsed) {
    return 'Elapsed Time: ${elapsed.toString()}';
  }

  @protected
  Stopwatch startWatch() {
    final watch = Stopwatch();
    watch.start();
    return watch;
  }

  @protected
  void stopWatch(Stopwatch watch) {
    watch.stop();
  }
}
