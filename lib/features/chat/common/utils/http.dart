import 'dart:async';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:super_app/core/utils/local_storage.dart';
import 'package:super_app/features/chat/common/store/store.dart';
import 'package:super_app/features/chat/common/utils/utils.dart';
import 'package:super_app/features/chat/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide FormData;

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;

  late Dio dio;
  CancelToken cancelToken = new CancelToken();

  HttpUtil._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = new BaseOptions(
      // 请求基地址,可以包含子路径
      baseUrl: SERVER_API_URL,

      // baseUrl: storage.read(key: STORAGE_KEY_APIURL) ?? SERVICE_API_BASEURL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: Duration(milliseconds: 10000),

      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: Duration(milliseconds: 5000),

      // Http请求头.
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=utf-8',
      },

      /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
      contentType: 'application/json; charset=utf-8',

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。
      /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      ///
      /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
      /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      ///
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      responseType: ResponseType.json,

      // Add this to match Postman's behavior
      validateStatus: (status) {
        return true; // Accept any status code to see the full response
      },
    );

    dio = new Dio(options);

    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // Cookie管理
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    // 添加拦截器
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("\n=== Outgoing Request ===");
        print("URL: ${options.uri}");
        print("Method: ${options.method}");
        print("Headers:");
        options.headers.forEach((key, value) => print("$key: $value"));
        print("=====================");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print("\n=== Incoming Response ===");
        print("Status Code: ${response.statusCode}");
        print("Data: ${response.data}");
        print("=====================");
        return handler.next(response);
      },
      onError: (error, handler) {
        print("\n=== Error Details ===");
        print("Type: ${error.type}");
        print("Message: ${error.message}");
        print("Response: ${error.response?.data}");
        print("=====================");
        return handler.next(error);
      },
    ));
  }

  /*
   * error统一处理
   */

  // 错误处理
  void onError(ErrorEntity eInfo) {
    print('error.code -> ' +
        eInfo.code.toString() +
        ', error.message -> ' +
        eInfo.message);
    switch (eInfo.code) {
      case 401:
        // UserStore.to.onLogout();
        EasyLoading.showError(eInfo.message);
        break;
      default:
        EasyLoading.showError('未知错误');
        break;
    }
  }

  // 错误信息
  ErrorEntity createErrorEntity(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return ErrorEntity(code: -1, message: "请求取消");
      case DioExceptionType.connectionTimeout:
        return ErrorEntity(code: -1, message: "连接超时");
      case DioExceptionType.sendTimeout:
        return ErrorEntity(code: -1, message: "请求超时");
      case DioExceptionType.receiveTimeout:
        return ErrorEntity(code: -1, message: "响应超时");
      case DioExceptionType.badResponse:
        {
          try {
            int errCode =
                error.response != null ? error.response!.statusCode! : -1;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                return ErrorEntity(code: errCode, message: "请求语法错误");
              case 401:
                return ErrorEntity(code: errCode, message: "没有权限");
              case 403:
                return ErrorEntity(code: errCode, message: "服务器拒绝执行");
              case 404:
                return ErrorEntity(code: errCode, message: "无法连接服务器");
              case 405:
                return ErrorEntity(code: errCode, message: "请求方法被禁止");
              case 500:
                return ErrorEntity(code: errCode, message: "服务器内部错误");
              case 502:
                return ErrorEntity(code: errCode, message: "无效的请求");
              case 503:
                return ErrorEntity(code: errCode, message: "服务器挂了");
              case 505:
                return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
              default:
                {
                  // return ErrorEntity(code: errCode, message: "未知错误");
                  return ErrorEntity(
                    code: errCode,
                    message: error.response != null
                        ? error.response!.statusMessage!
                        : "",
                  );
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "未知错误");
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message ?? "");
        }
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  /// 读取本地配置
  /// 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    final token = LocalStorage.instance.getAccessToken();

    if (token != null && token.isNotEmpty) {
      // Ensure exact header format as Postman
      headers['Authorization'] = 'Bearer $token';

      // Debug logging
      print("\n=== Auth Header Check ===");
      print("Token from storage: $token");
      print("Final header value: ${headers['Authorization']}");
      print("=====================");
    }

    return headers;
  }

  /// restful get 操作
  /// refresh 是否下拉刷新 默认 false
  /// noCache 是否不缓存 默认 true
  /// list 是否列表 默认 false
  /// cacheKey 缓存key
  /// cacheDisk 是否磁盘缓存
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    bool list = false,
    String cacheKey = '',
    bool cacheDisk = false,
  }) async {
    try {
      Options requestOptions = options ?? Options();
      requestOptions.headers = requestOptions.headers ?? {};
      Map<String, dynamic>? authorization = getAuthorizationHeader();
      if (authorization != null) {
        requestOptions.headers!.addAll(authorization);
      }

      // Ensure query parameters are properly formatted
      if (path.contains('listusers')) {
        queryParameters = {
          'page_id': '1',
          'page_size': '5',
        };
      }

      // Log request details
      print('\nGET Request Details:');
      print('URL: ${dio.options.baseUrl}$path');
      print('Headers: ${requestOptions.headers}');
      print('Query Parameters: $queryParameters');
      print('Extra Options: ${requestOptions.extra}');

      var response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
      );

      // Log successful response
      print('\nResponse Details:');
      print('Status Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print('Response Data: ${response.data}');

      return response.data;
    } on DioException catch (e) {
      // Log detailed error information
      print('\nDio Error Details:');
      print('Error Type: ${e.type}');
      print('Error Message: ${e.message}');
      print('Error Path: ${e.requestOptions.path}');
      print('Status Code: ${e.response?.statusCode}');

      if (e.response != null) {
        print('Response Headers: ${e.response?.headers}');
        print('Response Data: ${e.response?.data}');
      }

      // Additional connection error details
      if (e.type == DioExceptionType.connectionTimeout) {
        print('Connection timed out. Please check your internet connection.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        print('Server took too long to respond.');
      }

      rethrow;
    } catch (e) {
      // Log any other types of errors
      print('\n=== Request Failed ===');
      print('Error: $e');
      print('====================');
      rethrow;
    }
  }

  /// restful post 操作
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      Options requestOptions = options ?? Options();
      requestOptions.headers = requestOptions.headers ?? {};
      Map<String, dynamic>? authorization = getAuthorizationHeader();
      if (authorization != null) {
        requestOptions.headers!.addAll(authorization);
      }

      // Log request details
      print('\nPOST Request Details:');
      print('URL: ${dio.options.baseUrl}$path');
      print('Headers: ${requestOptions.headers}');
      print('Query Parameters: $queryParameters');
      print('Request Data: $data');
      print('Extra Options: ${requestOptions.extra}');
      print('=====================');

      var response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
      );

      // Log successful response
      print('\nResponse Details:');
      print('Status Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print('Response Data: ${response.data}');
      print('=====================');

      return response.data;
    } on DioException catch (e) {
      // Log detailed error information
      print('\nDio Error Details:');
      print('Error Type: ${e.type}');
      print('Error Message: ${e.message}');
      print('Error Path: ${e.requestOptions.path}');
      print('Status Code: ${e.response?.statusCode}');

      if (e.response != null) {
        print('Response Headers: ${e.response?.headers}');
        print('Response Data: ${e.response?.data}');
      }

      // Additional connection error details
      if (e.type == DioExceptionType.connectionTimeout) {
        print('Connection timed out. Please check your internet connection.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        print('Server took too long to respond.');
      }

      rethrow;
    } catch (e) {
      // Log any other types of errors
      print('\n=== Request Failed ===');
      print('Error: $e');
      print('====================');
      rethrow;
    }
  }

  /// restful put 操作
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful patch 操作
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful delete 操作
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful post form 表单提交操作
  Future postForm(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.post(
      path,
      data: FormData.fromMap(data as Map<String, dynamic>),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful post Stream 流数据
  Future postStream(
    String path, {
    dynamic data,
    int dataLength = 0,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    requestOptions.headers!.addAll({
      Headers.contentLengthHeader: dataLength.toString(),
    });
    var response = await dio.post(
      path,
      data: Stream.fromIterable((data as Iterable).map((e) => [e])),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }
}

// 异常处理
class ErrorEntity implements Exception {
  int code = -1;
  String message = "";
  ErrorEntity({required this.code, required this.message});

  String toString() {
    if (message == "") return "Exception";
    return "Exception: code $code, $message";
  }
}
