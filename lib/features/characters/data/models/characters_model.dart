import 'package:rick_and_morty_characters/core/shared/data/models/character_model.dart';
import 'package:rick_and_morty_characters/features/characters/data/models/characters_info_model.dart';
import 'package:rick_and_morty_characters/features/characters/domain/entities/characters_entity.dart';

final class CharactersModel {
  final CharactersInfoModel info;
  final List<CharacterModel> results;

  CharactersModel({required this.info, required this.results});

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    return CharactersModel(
      info: CharactersInfoModel.fromJson(json['info']),
      results: (json['results'] as List)
          .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  CharactersEntity toEntity() {
    return CharactersEntity(
      info: info.toEntity(),
      results: results.map((value) => value.toEntity()).toList(),
    );
  }
}
