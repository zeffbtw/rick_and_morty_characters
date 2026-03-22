enum FavoritesSortType {
  byName('Name'),
  byGender('Gender'),
  none('none');

  final String name;
  const FavoritesSortType(this.name);
}
