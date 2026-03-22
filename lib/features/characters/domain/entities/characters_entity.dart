import 'package:rick_and_morty_characters/core/shared/domain/entities/character_entity.dart';
import 'package:rick_and_morty_characters/features/characters/domain/entities/characters_info_entity.dart';

final class CharactersEntity {
  final CharactersInfoEntity info;
  final List<CharacterEntity> results;

  CharactersEntity({required this.info, required this.results});
}
