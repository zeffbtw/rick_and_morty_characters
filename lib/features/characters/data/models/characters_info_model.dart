import 'package:rick_and_morty_characters/features/characters/domain/entities/characters_info_entity.dart';

final class CharactersInfoModel {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  CharactersInfoModel({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory CharactersInfoModel.fromJson(Map<String, dynamic> json) {
    return CharactersInfoModel(
      count: num.parse(json['count'].toString()).toInt(),
      pages: num.parse(json['pages'].toString()).toInt(),
      next: json['next'],
      prev: json['prev'],
    );
  }

  CharactersInfoEntity toEntity() {
    return CharactersInfoEntity(count: count, pages: pages, next: next);
  }
}
