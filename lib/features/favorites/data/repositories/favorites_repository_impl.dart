import 'package:rick_and_morty_characters/core/shared/data/models/character_model.dart';
import 'package:rick_and_morty_characters/core/shared/domain/entities/character_entity.dart';
import 'package:rick_and_morty_characters/features/favorites/data/datasource/favorites_local_data_source.dart';
import 'package:rick_and_morty_characters/features/favorites/domain/repositories/favorites_repository.dart';

final class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource _favoritesLocalDataSource;

  FavoritesRepositoryImpl({required FavoritesLocalDataSource favoritesLocalDataSource})
    : _favoritesLocalDataSource = favoritesLocalDataSource;

  @override
  Future<void> addFavorite(CharacterEntity character) async {
    await _favoritesLocalDataSource.saveFavorite(CharacterModel.fromEntity(character));
  }

  @override
  Future<List<CharacterEntity>> getFavorites() async {
    final List<CharacterModel> result = await _favoritesLocalDataSource.getFavorites();

    return result.map((value) => value.toEntity()).toList();
  }

  @override
  Future<void> removeFavorite(int id) async {
    await _favoritesLocalDataSource.removeFavorite(id);
  }

  @override
  Future<bool> isFavorite(int id) async {
    final result = await _favoritesLocalDataSource.isFavorite(id);

    return result;
  }
}
