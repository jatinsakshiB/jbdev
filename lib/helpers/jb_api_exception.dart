import 'package:dio/dio.dart';

import '../utils/log.dart';

class JBApiException implements Exception {
  final Object e;
  final StackTrace stackTrace;
  final Object? extra;
  JBApiException(this.e, this.stackTrace, {this.extra}){
    Log.e(stackTrace);
  }

  bool isCancel(){
    if (e is DioException){
      if (CancelToken.isCancel(e as DioException)) {
        return true;
      }
    }
    return false;
  }

  @override
  String toString() {
    String message;
    if (e is DioException){
      message = (e as DioException).message ?? "";
    }else{
      message = e.toString();
    }
    return message;
  }
}