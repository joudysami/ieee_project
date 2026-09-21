import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ieee/core/constant/api_endpoint.dart';

class ApiClient {

  static final Dio _dio=Dio(
    BaseOptions(baseUrl:ApiEndpoint.baseUrl ,
    connectTimeout:  Duration(seconds: 10),
    receiveTimeout:  Duration(seconds: 10),
    headers: {
       'Content-Type': 'application/json',
        'Accept': 'application/json',
    }
    )
  );


static void init() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 1. جلب التوكن الحالي الحقيقي من Firebase تلقائياً
          final firebaseUser = FirebaseAuth.instance.currentUser;
          if (firebaseUser != null) {
            final token = await firebaseUser.getIdToken();
            // 2. حط التوكن في الـ Header قبل ما الـ Request يطلع
           
           print("================ FIREBASE ID TOKEN ================");
          print(token);
          print("==================================================");
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options); // كمل الـ Request عادي
        },
        onError: (DioException error, handler) {
          // لو السيرفر رد بـ 401 UnAuthorized مثلاً أو مشكلة شبكة
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
    return await _dio.get(
      path,
      queryParameters: queryParameters,
    );
  }

  // ✅ 2. POST Request
  static Future<Response> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  // ✅ 3. PUT Request
  static Future<Response> put({
    required String path,
    dynamic data,
  }) async {
    return await _dio.put(
      path,
      data: data,
    );
  }

  // ✅ 4. DELETE Request
  static Future<Response> delete({
    required String path,
    dynamic data,
  }) async {
    return await _dio.delete(
      path,
      data: data,
    );
  }

  static Dio get dio=> _dio;
}