import 'package:rick_and_morty_characters/features/characters/data/datasource/characters_local_data_source.dart';
import 'package:rick_and_morty_characters/features/characters/data/datasource/characters_remote_datasource.dart';
import 'package:rick_and_morty_characters/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty_characters/features/characters/domain/entities/characters_entity.dart';
import 'package:rick_and_morty_characters/features/characters/domain/repositories/characters_repository.dart';

final class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersRemoteDataSource _characterRemoteDataSource;
  final CharactersLocalDataSource _characterLocalDataSource;

  CharactersRepositoryImpl({
    required CharactersRemoteDataSource characterRemoteDataSource,
    required CharactersLocalDataSource characterLocalDataSource,
  }) : _characterRemoteDataSource = characterRemoteDataSource,
       _characterLocalDataSource = characterLocalDataSource;

  @override
  Future<CharactersEntity> getCharacters({int? page}) async {
    CharactersModel result;

    try {
      result = await _characterRemoteDataSource.getCharacters(page: page);
      _characterLocalDataSource.saveCharacters(value: result, page: page);
    } catch (_) {
      result = _characterLocalDataSource.getCharacters(page: page);
    }

    return result.toEntity();
  }
}
