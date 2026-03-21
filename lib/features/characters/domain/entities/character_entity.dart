import 'package:rick_and_morty_characters/features/characters/domain/entities/character_gender_enum.dart';

class CharacterEntity {
  final int id;
  final String name;
  final String imagUrl;
  final CharacterGenderEnum gender;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.imagUrl,
    required this.gender,
  });
}
