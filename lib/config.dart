import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class Config {
  static final String apiUrl = _getApiUrl();

  static String _getApiUrl() {
    if (kIsWeb) {
      // 웹 환경에서는 String.fromEnvironment를 사용합니다.
      return const String.fromEnvironment('DAYWON_PORT',
          defaultValue: 'http://localhost:8000');
    } else {
      // 모바일 환경에서는 Platform.environment를 사용합니다.
      if (Platform.environment.containsKey('DAYWON_PORT')) {
        return Platform.environment['DAYWON_PORT']!;
      } else {
        return 'http://localhost:8000';
      }
    }
  }
}
