// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:soq_app/app/app_prefs.dart';
import 'package:soq_app/app/constants.dart';

const String APPLICATIO_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFFAULT_LANGUAGE = "language";

class DioFactory {
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);
  Future<Dio> getDio() async {
    Dio dio = Dio();
    String token = await _appPreferences.getUserToken();
    String language = await _appPreferences.getAppLanguage();
    Map<String, dynamic> headers = {
      CONTENT_TYPE: APPLICATIO_JSON,
      ACCEPT: APPLICATIO_JSON,
      AUTHORIZATION: token,
      DEFFAULT_LANGUAGE: language,
    };
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: Constants.apiTimeOut,
      sendTimeout: Constants.apiTimeOut,
    );
    // if (!kReleaseMode) {
    //   dio.interceptors.add(PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseHeader: true,
    //   ));
    // }
    return dio;
  }
}
