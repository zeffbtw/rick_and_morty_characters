import 'package:rick_and_morty_characters/core/shared/domain/entities/character_entity.dart';

abstract class FavoritesRepository {
  Future<List<CharacterEntity>> getFavorites();
  Future<void> addFavorite(CharacterEntity character);
  Future<void> removeFavorite(int id);
  Future<bool> isFavorite(int id);
}
