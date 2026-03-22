import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:rick_and_morty_characters/core/storage/local_storage_keys.dart';
import 'package:rick_and_morty_characters/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty_characters/hive/hive_registrar.g.dart';

abstract interface class LocalStorageService {
  Future<LocalStorageService> init();
  void dispose();

  T? read<T>({required LocalStorageKey<T> box, required String key});

  Future<void> write<T>({
    required LocalStorageKey<T> box,
    required String key,
    required T value,
  });

  Future<void> delete<T>({required LocalStorageKey<T> box, required String key});

  bool contains<T>({required LocalStorageKey<T> box, required String key});

  List<T> readAll<T>({required LocalStorageKey<T> box});

  Future<void> clear<T>({required LocalStorageKey<T> box});
}

final class LocalStorageServiceImpl implements LocalStorageService {
  @override
  Future<LocalStorageService> init() async {
    await Hive.initFlutter();
    Hive.registerAdapters();
    await _openBoxes();

    return this;
  }

  Future<void> _openBoxes() async {
    await Hive.openBox<CharactersModel>(LocalStorageKeys.characters.name);
    await Hive.openBox<int>(LocalStorageKeys.favorites.name);
  }

  Box<T> _getBox<T>(LocalStorageKey<T> box) {
    return Hive.box<T>(box.name);
  }

  @override
  T? read<T>({required LocalStorageKey<T> box, required String key}) {
    return _getBox(box).get(key);
  }

  @override
  Future<void> write<T>({
    required LocalStorageKey<T> box,
    required String key,
    required T value,
  }) async {
    await _getBox(box).put(key, value);
  }

  @override
  Future<void> delete<T>({required LocalStorageKey<T> box, required String key}) async {
    await _getBox(box).delete(key);
  }

  @override
  bool contains<T>({required LocalStorageKey<T> box, required String key}) {
    return _getBox(box).containsKey(key);
  }

  @override
  List<T> readAll<T>({required LocalStorageKey<T> box}) {
    return _getBox(box).values.toList();
  }

  @override
  Future<void> clear<T>({required LocalStorageKey<T> box}) async {
    await _getBox(box).clear();
  }

  @override
  Future<void> dispose() async {
    await Hive.close();
  }
}
