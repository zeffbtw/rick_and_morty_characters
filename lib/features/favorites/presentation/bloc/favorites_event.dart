part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

final class FavoritesLoadRequest extends FavoritesEvent {}

final class FavoritesToggleRequest extends FavoritesEvent {
  final CharacterEntity character;

  const FavoritesToggleRequest(this.character);

  @override
  List<Object> get props => [character];
}
