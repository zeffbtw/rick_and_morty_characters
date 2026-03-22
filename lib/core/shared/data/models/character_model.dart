import 'package:rick_and_morty_characters/core/shared/domain/entities/character_entity.dart';
import 'package:rick_and_morty_characters/core/shared/domain/entities/character_gender_enum.dart';

class CharacterModel extends CharacterEntity {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.imagUrl,
    required super.gender,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: num.parse(json['id'].toString()).toInt(),
      name: json['name'].toString(),
      imagUrl: json['image'].toString(),
      gender: CharacterGenderEnum.byName(json['gender'].toString()),
    );
  }
}
