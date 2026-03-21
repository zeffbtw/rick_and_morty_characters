enum CharacterGenderEnum {
  male('Male'),
  female('Female'),
  genderless('Genderless'),
  unknown('unknown');

  final String name;
  const CharacterGenderEnum(this.name);

  static CharacterGenderEnum byName(String? name) {
    return values.firstWhere((element) => element.name == name, orElse: () => unknown);
  }
}
