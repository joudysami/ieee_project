import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ieee/core/constant/api_endpoint.dart';
import '../storage/secure_storage.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoint.baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  static void init() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final backendToken = await SecureStorage.getBackendToken();
          if (backendToken != null && backendToken.isNotEmpty) {
            log("================ SENDING BACKEND TOKEN ================");
            log(backendToken);
            log("=======================================================");

            // Inject the backend token instead of the Firebase token
            options.headers['Authorization'] = 'Bearer $backendToken';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) {
          if (error.response?.statusCode == 401) {
            log("401 UNAUTHORIZED - Token is invalid or expired");
          }
          return handler.next(error);
        },
      ),
    );
  }

  // ✅ 1. GET Request
  static Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  // ✅ 2. POST Request
  static Future<Response> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.post(path, data: data, queryParameters: queryParameters);
  }

  // ✅ 3. PUT Request
  static Future<Response> put({required String path, dynamic data}) async {
    return await _dio.put(path, data: data);
  }

  // ✅ 4. DELETE Request
  static Future<Response> delete({required String path, dynamic data}) async {
    return await _dio.delete(path, data: data);
  }

  static Dio get dio => _dio;
}
