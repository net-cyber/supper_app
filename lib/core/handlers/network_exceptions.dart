import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.connectionError() = ConnectionError;

  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorisedRequest() = UnauthorisedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  const factory NetworkExceptions.badCertificate() = BadCertificate;

  /// Extract the raw error message directly from a DioException or any error
  static String getRawErrorMessage(dynamic error) {
    if (error is DioException && error.response?.data != null) {
      try {
        // For JSON error responses
        if (error.response!.data is Map<String, dynamic>) {
          final errorData = error.response!.data as Map<String, dynamic>;
          // Return error field if it exists
          if (errorData.containsKey('error')) {
            return errorData['error'].toString();
          }
          // Return message field if it exists
          else if (errorData.containsKey('message')) {
            return errorData['message'].toString();
          }
          // Return the entire JSON as a string
          else {
            return json.encode(errorData);
          }
        }
        // For string error responses
        else if (error.response!.data is String) {
          return error.response!.data as String;
        }
        // For other types of data, try to convert to string
        else {
          return error.response!.data.toString();
        }
      } catch (e) {
        // If parsing fails, return the error's toString
        return error.toString();
      }
    } else if (error is NetworkExceptions) {
      // Extract just the error message from NetworkExceptions
      return _extractMessageFromNetworkExceptions(error);
    }
    
    // Fallback to standard error handling
    return error.toString();
  }

  // Helper method to extract just the message from NetworkExceptions
  static String _extractMessageFromNetworkExceptions(NetworkExceptions networkExceptions) {
    return networkExceptions.when(
      connectionError: () => "Connection error",
      requestCancelled: () => "Request cancelled",
      unauthorisedRequest: () => "Unauthorized request",
      badRequest: () => "Bad request",
      notFound: (reason) => reason,
      methodNotAllowed: () => "Method not allowed",
      notAcceptable: () => "Not acceptable",
      requestTimeout: () => "Request timeout",
      sendTimeout: () => "Send timeout",
      conflict: () => "Conflict",
      internalServerError: () => "Internal server error",
      notImplemented: () => "Not implemented",
      serviceUnavailable: () => "Service unavailable",
      noInternetConnection: () => "No internet connection",
      formatException: () => "Format exception",
      unableToProcess: () => "Unable to process",
      defaultError: (error) => error, // Return just the error string
      unexpectedError: () => "Unexpected error",
      badCertificate: () => "Bad certificate",
    );
  }

  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions? networkExceptions;
        if (error is DioException) {
          // First handle network-related exceptions that aren't related to response content
          switch (error.type) {
            case DioExceptionType.connectionError:
              return const NetworkExceptions.connectionError();
            case DioExceptionType.cancel:
              return const NetworkExceptions.requestCancelled();
            case DioExceptionType.connectionTimeout:
              return const NetworkExceptions.requestTimeout();
            case DioExceptionType.unknown:
              return const NetworkExceptions.noInternetConnection();
            case DioExceptionType.receiveTimeout:
              return const NetworkExceptions.sendTimeout();
            case DioExceptionType.badCertificate:
              return const NetworkExceptions.badCertificate();
            case DioExceptionType.sendTimeout:
              return const NetworkExceptions.sendTimeout();
            case DioExceptionType.badResponse:
              // For responses, always extract and return the backend error message
              String backendError = _extractBackendErrorMessage(error.response?.data);
              return NetworkExceptions.defaultError(backendError);
          }
        } else if (error is SocketException) {
          return const NetworkExceptions.noInternetConnection();
        } else {
          return const NetworkExceptions.unexpectedError();
        }
        return networkExceptions ?? const NetworkExceptions.unexpectedError();
      } on FormatException catch (_) {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  // Helper method to extract backend error messages
  static String _extractBackendErrorMessage(dynamic data) {
    if (data == null) return "Unknown error occurred";
    
    try {
      // For JSON error responses
      if (data is Map<String, dynamic>) {
        if (data.containsKey('error')) {
          return data['error'].toString();
        } else if (data.containsKey('message')) {
          return data['message'].toString();
        } else {
          // If no specific error field, return the entire JSON as a message
          return json.encode(data);
        }
      }
      // For string error responses
      else if (data is String && data.isNotEmpty) {
        // Try to parse as JSON first
        try {
          final jsonData = json.decode(data);
          if (jsonData is Map<String, dynamic>) {
            if (jsonData.containsKey('error')) {
              return jsonData['error'].toString();
            } else if (jsonData.containsKey('message')) {
              return jsonData['message'].toString();
            }
          }
          return data;
        } catch (_) {
          // If not valid JSON, return the string as is
          return data;
        }
      } else {
        // For other data types, convert to string
        return data.toString();
      }
    } catch (_) {
      // If any parsing error occurs, return a generic message
      return "Error processing response";
    }
  }
}