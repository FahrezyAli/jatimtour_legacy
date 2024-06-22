import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

ImageProvider getLocalImage(String path) {
  if (kIsWeb && !kDebugMode) {
    return NetworkImage('assets/$path');
  } else {
    return AssetImage(path);
  }
}
