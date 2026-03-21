import 'package:rick_and_morty_characters/features/characters/data/models/character_model.dart';
import 'package:rick_and_morty_characters/features/characters/data/models/characters_info_model.dart';
import 'package:rick_and_morty_characters/features/characters/domain/entities/characters_entity.dart';

class CharactersModel extends CharactersEntity {
  CharactersModel({required super.info, required super.characters});

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    return CharactersModel(
      info: CharactersInfoModel.fromJson(json['info']),
      characters: (json['results'] as List)
          .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
