import 'package:dio/dio.dart';
import 'package:jbdev/helpers/jb_api_exception.dart';

import 'api_methods.dart';
import 'dio_client.dart';

class Api {
  final String endPoint;
  final ApiMethods apiMethod;
  final dynamic data;

  Api(this.endPoint, {this.apiMethod = ApiMethods.get, this.data});

  Dio dio = DioClient.dio;

  Future<dynamic> call({CancelToken? cancelToken}) async {
    var method = apiMethod.name.toUpperCase();

    bool isData = apiMethod == ApiMethods.post || apiMethod == ApiMethods.put;
    try{
      final response = await dio.request(endPoint,
          data: isData ? data : null,
          queryParameters: !isData ? data : null,
          options: Options(
            method: method,
          ),
          cancelToken: cancelToken);
      return response.data;
    }catch(e, stackTrace){
      throw JBApiException(e, stackTrace);
    }
  }
}
