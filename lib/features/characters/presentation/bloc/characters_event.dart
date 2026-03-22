part of 'characters_bloc.dart';

sealed class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object> get props => [];
}

final class CharactersLoadRequest extends CharactersEvent {
  const CharactersLoadRequest();
}

final class CharactersLoadMoreRequest extends CharactersEvent {
  const CharactersLoadMoreRequest();
}

final class CharactersFavoriteTap extends CharactersEvent {
  final CharacterEntity character;

  const CharactersFavoriteTap({required this.character});

  @override
  List<Object> get props => [character];
}
