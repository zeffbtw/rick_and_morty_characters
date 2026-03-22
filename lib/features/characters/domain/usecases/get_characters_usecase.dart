import 'package:rick_and_morty_characters/core/usecases/usecase.dart';
import 'package:rick_and_morty_characters/features/characters/domain/entities/characters_entity.dart';
import 'package:rick_and_morty_characters/features/characters/domain/repositories/characters_repository.dart';

final class GetCharactersUseCase implements UseCase<CharactersEntity, int?> {
  final CharactersRepository _repository;

  GetCharactersUseCase(this._repository);

  @override
  Future<CharactersEntity> call(int? params) => _repository.getCharacters(page: params);
}
