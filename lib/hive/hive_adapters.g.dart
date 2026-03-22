// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class CharacterGenderEnumAdapter extends TypeAdapter<CharacterGenderEnum> {
  @override
  final typeId = 1;

  @override
  CharacterGenderEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CharacterGenderEnum.male;
      case 1:
        return CharacterGenderEnum.female;
      case 2:
        return CharacterGenderEnum.genderless;
      case 3:
        return CharacterGenderEnum.unknown;
      default:
        return CharacterGenderEnum.male;
    }
  }

  @override
  void write(BinaryWriter writer, CharacterGenderEnum obj) {
    switch (obj) {
      case CharacterGenderEnum.male:
        writer.writeByte(0);
      case CharacterGenderEnum.female:
        writer.writeByte(1);
      case CharacterGenderEnum.genderless:
        writer.writeByte(2);
      case CharacterGenderEnum.unknown:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterGenderEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CharacterModelAdapter extends TypeAdapter<CharacterModel> {
  @override
  final typeId = 2;

  @override
  CharacterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterModel(
      id: (fields[0] as num).toInt(),
      name: fields[1] as String,
      imagUrl: fields[2] as String,
      gender: fields[3] as CharacterGenderEnum,
    );
  }

  @override
  void write(BinaryWriter writer, CharacterModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imagUrl)
      ..writeByte(3)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CharactersModelAdapter extends TypeAdapter<CharactersModel> {
  @override
  final typeId = 4;

  @override
  CharactersModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharactersModel(
      info: fields[0] as CharactersInfoModel,
      results: (fields[1] as List).cast<CharacterModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CharactersModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.info)
      ..writeByte(1)
      ..write(obj.results);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharactersModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CharactersInfoModelAdapter extends TypeAdapter<CharactersInfoModel> {
  @override
  final typeId = 5;

  @override
  CharactersInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharactersInfoModel(
      count: (fields[0] as num).toInt(),
      pages: (fields[1] as num).toInt(),
      next: fields[2] as String?,
      prev: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CharactersInfoModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.pages)
      ..writeByte(2)
      ..write(obj.next)
      ..writeByte(3)
      ..write(obj.prev);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharactersInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
