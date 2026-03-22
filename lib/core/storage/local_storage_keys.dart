import 'package:rick_and_morty_characters/features/characters/data/models/characters_model.dart';

final class LocalStorageKey<T> {
  final String name;
  const LocalStorageKey(this.name);
}

abstract final class LocalStorageKeys {
  static const characters = LocalStorageKey<CharactersModel>('characters');
  static const favorites = LocalStorageKey<int>('favorites');
}
