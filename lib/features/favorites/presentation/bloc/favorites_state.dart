part of 'favorites_bloc.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<CharacterEntity> favorites;
  final FavoritesSortType sortType;

  const FavoritesLoaded({
    required this.favorites,
    this.sortType = FavoritesSortType.none,
  });

  FavoritesLoaded copyWith({
    List<CharacterEntity>? favorites,
    FavoritesSortType? sortType,
  }) {
    return FavoritesLoaded(
      favorites: favorites ?? this.favorites,
      sortType: sortType ?? this.sortType,
    );
  }

  @override
  List<Object> get props => [favorites, sortType];
}
