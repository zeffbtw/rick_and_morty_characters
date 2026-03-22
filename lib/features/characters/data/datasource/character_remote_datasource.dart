import 'package:dio/dio.dart';
import 'package:rick_and_morty_characters/core/constants/api_constants.dart';
import 'package:rick_and_morty_characters/core/error/exceptions.dart';
import 'package:rick_and_morty_characters/features/characters/data/models/characters_model.dart';

abstract class CharacterRemoteDataSource {
  Future<CharactersModel> getCharacters({int? page});
}

final class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio _dio;

  const CharacterRemoteDataSourceImpl(this._dio);

  @override
  Future<CharactersModel> getCharacters({int? page}) async {
    try {
      final response = await _dio.get(
        ApiConstants.character,
        queryParameters: {'page': page},
      );

      if (response.statusCode != 200 || response.data == null) {
        throw ServerException(
          message: 'Error get characters data',
          statusCode: response.statusCode ?? 0,
        );
      }

      return CharactersModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['detail'],
        statusCode: e.response?.statusCode ?? 0,
      );
    }
  }
}
