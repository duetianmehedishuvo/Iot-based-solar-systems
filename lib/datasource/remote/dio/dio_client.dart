import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:women_safety/datasource/remote/dio/logging_interceptor.dart';
import 'package:women_safety/util/app_constant.dart';

class DioClient {
  final String baseUrl;
  late LoggingInterceptor? loggingInterceptor;
  late SharedPreferences? sharedPreferences;

  Dio dio = Dio();
  String token = '';
  Dio dio1 = Dio();

  DioClient(this.baseUrl, Dio dioC, {this.loggingInterceptor, this.sharedPreferences}) {
    token = sharedPreferences!.getString(AppConstant.token) ?? "";
    print("NNNN $token");
    dio = dioC;
    dio1 = dioC;
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(minutes: 3)
      ..options.receiveTimeout = const Duration(minutes: 3)
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8', "Accept": "application/json"};
    dio.interceptors.add(loggingInterceptor!);
  }

  clearDio() {
    dio.close(force: true);
    dio = Dio();
    dio = dio1;
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(minutes: 3)
      ..options.receiveTimeout = const Duration(minutes: 3)
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8', "Accept": "application/json", 'Authorization': 'Bearer $token'};
    dio.interceptors.add(loggingInterceptor!);
  }


  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
