import 'package:rick_and_morty_characters/core/storage/local_storage_keys.dart';
import 'package:rick_and_morty_characters/core/storage/local_storage_service.dart';
import 'package:rick_and_morty_characters/features/characters/data/models/characters_info_model.dart';
import 'package:rick_and_morty_characters/features/characters/data/models/characters_model.dart';

abstract class CharactersLocalDataSource {
  CharactersModel getCharacters({int? page});

  Future<void> saveCharacters({required CharactersModel value, int? page});
}

final class CharactersLocalDataSourceImpl implements CharactersLocalDataSource {
  final LocalStorageService _localStorageService;

  CharactersLocalDataSourceImpl({required LocalStorageService localStorageService})
    : _localStorageService = localStorageService;

  @override
  CharactersModel getCharacters({int? page}) {
    final result = _localStorageService.read<CharactersModel>(
      box: LocalStorageKeys.characters,
      key: (page ?? 1).toString(),
    );

    return result ??
        CharactersModel(
          info: CharactersInfoModel(count: 0, pages: 0, next: null, prev: null),
          results: [],
        );
  }

  @override
  Future<void> saveCharacters({required CharactersModel value, int? page}) async {
    await _localStorageService.write(
      box: LocalStorageKeys.characters,
      key: (page ?? 1).toString(),
      value: value,
    );
  }
}
