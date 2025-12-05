import 'package:dio/dio.dart';
import 'package:exch_app/src/constants.dart';
import 'package:exch_app/src/utils/application/storage/storage_helper.dart';
import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:get_it/get_it.dart';

Future<void> initApiHelper() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: kBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  final apiHelper = ApiHelper._(dio)..setupIntercepter();
  GetIt.instance.registerSingleton<ApiHelper>(
    apiHelper,
  );
  assert(GetIt.instance.isRegistered<ApiHelper>());
  log('Registered Api Helper Dependency');
}

ApiHelper get apiHelper => GetIt.instance.get<ApiHelper>();

class ApiHelper {
  final Dio dioClient;
  ApiHelper._(this.dioClient);

  void setupIntercepter() {
    // Add logging interceptors
    dioClient.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log(
            'API Request: ${options.method} ${options.uri}\n'
            'Headers: ${options.headers}\n'
            'Data: ${options.data}',
            name: 'API',
          );

          // Add Auth Token if available
          final token = GetIt.instance.get<StorageHelper>().authToken;
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          log(
            'API Response: ${response.statusCode} ${response.requestOptions.uri}\n'
            'Data: ${response.data}',
            name: 'API',
          );
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          log(
            'API Error: ${error.type} ${error.requestOptions.uri}\n'
            'Message: ${error.message}',
            name: 'API',
            error: error,
            stackTrace: error.stackTrace,
          );
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return dioClient.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return dioClient.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
