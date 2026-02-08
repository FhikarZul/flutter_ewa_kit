import 'package:dio/dio.dart';
import 'package:ewa_kit/utils/network/ewa_response_exception.dart';

/// Extension on DioException to provide easy conversion to EwaResponseException
extension DioExceptionExtension on DioException {
  /// Converts a DioException to an EwaResponseException
  EwaResponseException toEwaResponseException() {
    return EwaResponseException.fromDioException(this);
  }
}
