import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_characters/core/shared/domain/entities/character_gender_enum.dart';

class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String imagUrl;
  final CharacterGenderEnum gender;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.imagUrl,
    required this.gender,
  });

  @override
  List<Object?> get props => [id, name, imagUrl, gender];
}
