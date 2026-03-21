import 'package:dio/dio.dart';
import 'package:rick_and_morty_characters/core/constants/api_constants.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class DioClient {
  DioClient({Dio? dio, Talker? talker})
    : talker = talker ?? Talker(),
      dio = (dio ?? Dio()) {
    this.dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      sendTimeout: ApiConstants.sendTimeout,
      contentType: Headers.jsonContentType,
    );

    this.dio.interceptors.add(
      TalkerDioLogger(
        talker: this.talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: false,
          printResponseMessage: true,
        ),
      ),
    );
  }

  final Dio dio;
  final Talker talker;
}
