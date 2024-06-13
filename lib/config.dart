import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class Config {
  static final String apiUrl = _getApiUrl();

  static String _getApiUrl() {
    String url;
    if (kIsWeb) {
      // 웹 환경에서는 String.fromEnvironment를 사용합니다.
      url = const String.fromEnvironment('DAYWON_PORT', defaultValue: 'http://localhost:8000');
      print('API URL for Web: $url');
    } else {
      // 모바일 환경에서는 코드 내에서 직접 환경 변수를 설정합니다.
      url = 'http://aiselab.asuscomm.com:9000';
      print('Default API URL: $url');
      // Android 에뮬레이터에서 localhost를 10.0.2.2로 변환
      if (Platform.isAndroid && url.contains('localhost')) {
        url = url.replaceAll('localhost', '10.0.2.2');
      }
      print('API URL for Mobile: $url');
    }
   
    return url;
  }
}