import 'package:rick_and_morty_characters/core/shared/domain/entities/character_entity.dart';
import 'package:rick_and_morty_characters/core/shared/domain/entities/character_gender_enum.dart';

class CharacterModel {
  final int id;
  final String name;
  final String imagUrl;
  final CharacterGenderEnum gender;

  CharacterModel({
    required this.id,
    required this.name,
    required this.imagUrl,
    required this.gender,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: num.parse(json['id'].toString()).toInt(),
      name: json['name'].toString(),
      imagUrl: json['image'].toString(),
      gender: CharacterGenderEnum.byName(json['gender'].toString()),
    );
  }

  factory CharacterModel.fromEntity(CharacterEntity entity) {
    return CharacterModel(
      id: entity.id,
      name: entity.name,
      imagUrl: entity.imagUrl,
      gender: entity.gender,
    );
  }

  CharacterEntity toEntity() {
    return CharacterEntity(id: id, name: name, imagUrl: imagUrl, gender: gender);
  }
}
