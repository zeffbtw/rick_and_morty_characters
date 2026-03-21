import 'package:rick_and_morty_characters/features/characters/domain/entities/characters_info_entity.dart';

class CharactersInfoModel extends CharactersInfoEntity {
  CharactersInfoModel({
    required super.count,
    required super.pages,
    required super.next,
    required super.prev,
  });

  factory CharactersInfoModel.fromJson(Map<String, dynamic> json) {
    return CharactersInfoModel(
      count: num.parse(json['count']).toInt(),
      pages: num.parse(json['pages']).toInt(),
      next: json['next'].toString(),
      prev: json['prev'].toString(),
    );
  }
}
