import 'package:rick_and_morty_characters/core/shared/domain/entities/character_entity.dart';
import 'package:rick_and_morty_characters/core/usecases/usecase.dart';
import 'package:rick_and_morty_characters/features/favorites/domain/repositories/favorites_repository.dart';

final class GetFavoritesUseCase implements UseCase<List<CharacterEntity>, NoParams> {
  final FavoritesRepository _repository;

  GetFavoritesUseCase(this._repository);

  @override
  Future<List<CharacterEntity>> call(NoParams params) => _repository.getFavorites();
}
