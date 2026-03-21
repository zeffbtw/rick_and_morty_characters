import 'package:rick_and_morty_characters/features/characters/domain/entities/character_entity.dart';
import 'package:rick_and_morty_characters/features/characters/domain/entities/characters_info_entity.dart';

class CharactersEntity {
  final CharactersInfoEntity info;
  final List<CharacterEntity> characters;

  CharactersEntity({required this.info, required this.characters});
}
