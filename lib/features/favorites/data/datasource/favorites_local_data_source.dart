import 'package:rick_and_morty_characters/core/shared/data/models/character_model.dart';
import 'package:rick_and_morty_characters/core/storage/local_storage_keys.dart';
import 'package:rick_and_morty_characters/core/storage/local_storage_service.dart';

abstract class FavoritesLocalDataSource {
  Future<List<CharacterModel>> getFavorites();
  Future<void> saveFavorite(CharacterModel character);
  Future<void> removeFavorite(int id);
  Future<bool> isFavorite(int id);
}

final class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final LocalStorageService _localStorageService;

  FavoritesLocalDataSourceImpl({required LocalStorageService localStorageService})
    : _localStorageService = localStorageService;

  @override
  Future<List<CharacterModel>> getFavorites() async {
    final List<CharacterModel> result = _localStorageService.readAll(
      box: LocalStorageKeys.favorites,
    );

    return result;
  }

  @override
  Future<void> removeFavorite(int id) async {
    await _localStorageService.delete(
      box: LocalStorageKeys.favorites,
      key: id.toString(),
    );
  }

  @override
  Future<void> saveFavorite(CharacterModel character) async {
    await _localStorageService.write(
      box: LocalStorageKeys.favorites,
      key: character.id.toString(),
      value: character,
    );
  }

  @override
  Future<bool> isFavorite(int id) async {
    final result = _localStorageService.contains(
      box: LocalStorageKeys.favorites,
      key: id.toString(),
    );

    return result;
  }
}
