import 'package:dio/dio.dart';

final class RetryAfterInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;

  const RetryAfterInterceptor({required this.dio, this.maxRetries = 2});

  static const String _retryKey = 'retry_after_attempt';

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final response = err.response;
    final requestOptions = err.requestOptions;

    if (response?.statusCode != 429) {
      return handler.next(err);
    }

    final currentRetry = _getRetryCount(requestOptions);

    if (currentRetry >= maxRetries) {
      return handler.next(err);
    }

    final retryAfter = _parseRetryAfter(response);

    if (retryAfter == null) {
      return handler.next(err);
    }

    await Future<void>.delayed(retryAfter);

    final newOptions = _copyRequestOptionsWithRetry(requestOptions, currentRetry + 1);

    try {
      final retryResponse = await dio.fetch<dynamic>(newOptions);
      return handler.resolve(retryResponse);
    } on DioException catch (e) {
      return handler.next(e);
    } catch (e) {
      return handler.next(
        DioException(
          requestOptions: requestOptions,
          error: e,
          type: DioExceptionType.unknown,
        ),
      );
    }
  }

  int _getRetryCount(RequestOptions options) {
    final value = options.extra[_retryKey];
    if (value is int) return value;
    return 0;
  }

  RequestOptions _copyRequestOptionsWithRetry(RequestOptions options, int retryCount) {
    final extra = Map<String, dynamic>.from(options.extra);
    extra[_retryKey] = retryCount;

    return options.copyWith(extra: extra);
  }

  Duration? _parseRetryAfter(Response<dynamic>? response) {
    if (response == null) return null;

    final header = response.headers.value('retry-after');
    if (header == null || header.trim().isEmpty) return null;

    final seconds = int.tryParse(header.trim());
    if (seconds != null) {
      return Duration(seconds: seconds);
    }

    final retryDate = DateTime.tryParse(header);
    if (retryDate != null) {
      final diff = retryDate.difference(DateTime.now().toUtc());
      if (diff.isNegative) return Duration.zero;
      return diff;
    }

    return null;
  }
}
