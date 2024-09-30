import 'package:dio/dio.dart';
import 'package:women_safety/model/base/error_response.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioExceptionType.connectionTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            case DioExceptionType.unknown:
              errorDescription = "Connection to API server failed due to internet connection";
              break;
            case DioExceptionType.receiveTimeout:
              errorDescription = "Receive timeout in connection with API server";
              break;
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
              // case 404:
                case 403:
                // // DioClient d=DioClient(baseUrl, dioC)
                //   DioClient.refreshToken();
                //   break;
                case 500:
                  try {
                    errorDescription = error.response!.data['message'];
                  } catch (e) {
                    errorDescription = '500 error show';
                  }

                  break;
                case 406:
                  errorDescription = '406 error show';
                  break;
                case 401:
                case 400:
                case 503:
                  errorDescription = error.response!.data['message'];
                  break;
                case 404:
                  errorDescription = error.response!.statusMessage;
                  break;
                case 422:
                  errorDescription = error.response!.data['value']['errors'][0]['message'];
                  break;
                default:
                  ErrorResponse errorResponse = ErrorResponse.fromJson(error.response!.data);
                  if (errorResponse.error.isNotEmpty) {
                    errorDescription = errorResponse;
                  } else {
                    errorDescription = "Failed to load data - status code: ${error.response!.statusCode}";
                  }
              }
              break;
            case DioExceptionType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
            case DioExceptionType.badCertificate:
              errorDescription = "badCertificate Error";
              break;
            case DioExceptionType.connectionError:
              errorDescription = "Send Connection with Error";
              break;
          }
        } else {
          errorDescription = "Unexpected error occurred";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}
