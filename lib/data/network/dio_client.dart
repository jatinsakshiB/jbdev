
import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:jbdev/jbdev.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
      baseUrl: JBConfig.baseUrl!,
      connectTimeout: JBConfig.apiConfig.connectTimeout,
      receiveTimeout: JBConfig.apiConfig.receiveTimeout,
      sendTimeout: JBConfig.apiConfig.sendTimeout,
      validateStatus: (status) {
        return JBConfig.apiConfig.validStatuses.any((element) => element == status);
      },
      receiveDataWhenStatusError: true,
      headers: JBConfig.apiConfig.headers));

  static bool _interceptorsAdded = false;
  static void _addInterceptors() {
    if (_interceptorsAdded) return;
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      await _updateHeaders(options);
      Log.i("Api URL: ${options.method} - ${options.uri}");
      Log.i("Headers: ${options.headers}");
      Log.i("Request Body: ${options.data}");

      return handler.next(options);
    }, onResponse: (response, handler) {
      _handleResponseUi(response.data);

      Log.s("Response: ${response.data}");
      return handler.next(response);
    }, onError: (e, handler) {
      _handleResponseUi(e.response?.data);

      final errorMessage = e.response?.data["message"] ?? e.response?.data["error"] ?? e.message;
      Log.e("Error: ${e.response?.statusCode} - $errorMessage");
      Log.e("Response: ${e.response?.data}");

      return handler.next(e.copyWith(message: errorMessage));
    }));
    _interceptorsAdded = true;
  }

  static String _getDeviceOs() {
    if (kIsWeb) return 'web';

    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    if (Platform.isMacOS) return 'macos';
    if (Platform.isWindows) return 'windows';
    if (Platform.isLinux) return 'linux';
    if (Platform.isFuchsia) return 'fuchsia';

    return 'unknown';
  }

  static Future<void> _updateHeaders(RequestOptions options) async {
    String? token = SharedPreferencesManager.get("token");
    if (!token.isNullOrEmpty){
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept-Language'] = App.localeCode;

    var info = App.packageInfo;
    if (info != null){
      options.headers['App-Name'] = info.appName;
      options.headers['App-Version'] = info.buildNumber;
      options.headers['App-Version-Name'] = info.version;
      options.headers['App-Updated-Time'] = info.updateTime?.toFullDateTime();
      options.headers['App-Install-Time'] = info.installTime?.toFullDateTime();
      options.headers['App-Install-Store'] = info.installerStore;
    }

    options.headers['Device-Type'] = _getDeviceOs();
  }

  static void _handleResponseUi(dynamic data) {
    if (data == null) return;
    if (data['toast'] != null) {
      String toastMessage = data['toast'];
      toast(toastMessage);
    }
    if (data['popup'] != null) {
      JBPopup popup = JBPopup.fromJson(data['popup']);
      showJBPopup(popup);
    }
  }

  static Dio get dio {
    _addInterceptors();
    return _dio;
  }
}
