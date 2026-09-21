import 'package:dio/dio.dart';
import 'package:ieee/core/constant/app_string.dart'; 
class ServerFailure implements Exception {
  final String errMessage;

  ServerFailure(this.errMessage);

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(AppString.connectionTimeout);
      case DioExceptionType.sendTimeout:
        return ServerFailure(AppString.sendTimeout);
      case DioExceptionType.receiveTimeout:
        return ServerFailure(AppString.receiveTimeout);
      case DioExceptionType.badResponse:
        return ServerFailure._fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(AppString.requestCancelled);
      case DioExceptionType.connectionError:
        return ServerFailure(AppString.noInternetConnection);
      default:
        return ServerFailure(AppString.unexpectedError);
    }
  }

  factory ServerFailure._fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(
        response is Map && response.containsKey('message')
            ? response['message']
            : AppString.unauthorizedError,
      );
    } else if (statusCode == 404) {
      return ServerFailure(AppString.notFoundError);
    } else if (statusCode == 500) {
      return ServerFailure(AppString.internalServerError);
    } else {
      return ServerFailure(AppString.defaultServerError);
    }
  }
}