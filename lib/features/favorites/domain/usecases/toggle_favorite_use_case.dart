import 'package:rick_and_morty_characters/core/shared/domain/entities/character_entity.dart';
import 'package:rick_and_morty_characters/core/usecases/usecase.dart';
import 'package:rick_and_morty_characters/features/favorites/domain/repositories/favorites_repository.dart';

final class ToggleFavoriteUseCase implements UseCase<void, CharacterEntity> {
  final FavoritesRepository _repository;

  ToggleFavoriteUseCase(this._repository);

  @override
  Future<void> call(CharacterEntity character) async {
    if (await _repository.isFavorite(character.id) == false) {
      await _repository.addFavorite(character);
    } else {
      await _repository.removeFavorite(character.id);
    }
  }
}
