import 'package:hive_ce/hive_ce.dart';
import 'package:rick_and_morty_characters/core/shared/data/models/character_model.dart';
import 'package:rick_and_morty_characters/core/shared/domain/entities/character_gender_enum.dart';
import 'package:rick_and_morty_characters/features/characters/data/models/characters_info_model.dart';
import 'package:rick_and_morty_characters/features/characters/data/models/characters_model.dart';

@GenerateAdapters([
  AdapterSpec<CharacterModel>(),
  AdapterSpec<CharacterGenderEnum>(),
  AdapterSpec<CharactersModel>(),
  AdapterSpec<CharactersInfoModel>(),
])
part 'hive_adapters.g.dart';
