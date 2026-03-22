import 'package:rick_and_morty_characters/features/characters/domain/entities/characters_entity.dart';

abstract class CharactersRepository {
  Future<CharactersEntity> getCharacters({int? page});
}
