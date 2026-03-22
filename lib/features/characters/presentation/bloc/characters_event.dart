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
