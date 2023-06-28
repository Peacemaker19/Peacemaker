// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> de = {
  "Hello": "Hallo! Wie geht'dir?"
};
static const Map<String,dynamic> en = {
  "Hello": "Hello, How are you doing?"
};
static const Map<String,dynamic> hn = {
  "Hello": "नमस्ते, आप कैसे हैं?"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"de": de, "en": en, "hn": hn};
}
