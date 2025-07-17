import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'api_methods.dart';
import 'dio_client.dart';

class Api {
  final String endPoint;
  final ApiMethods apiMethod;
  final dynamic data;

  Api(this.endPoint, {this.apiMethod = ApiMethods.get, this.data});

  Dio dio = DioClient.dio;

  Future<dynamic> call(BuildContext context, {CancelToken? cancelToken}) async {
    DioClient.context = context;
    var method = apiMethod.name.toUpperCase();

    bool isData = apiMethod == ApiMethods.post || apiMethod == ApiMethods.put;
    final response = await dio.request(endPoint,
        data: isData ? data : null,
        queryParameters: !isData ? data : null,
        options: Options(
          method: method,
        ),
        cancelToken: cancelToken);
    return response.data;
  }
}
