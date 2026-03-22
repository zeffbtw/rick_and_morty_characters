part of 'characters_bloc.dart';

sealed class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

final class CharactersInitial extends CharactersState {}

final class CharactersLoading extends CharactersState {}

final class CharactersLoaded extends CharactersState {
  final List<CharacterEntity> characters;
  final int currentPage;
  final bool isLoadingMore;
  final bool hasReachedMax;

  const CharactersLoaded({
    required this.characters,
    required this.currentPage,
    required this.isLoadingMore,
    required this.hasReachedMax,
  });

  CharactersLoaded copyWith({
    List<CharacterEntity>? characters,
    int? currentPage,
    bool? isLoadingMore,
    bool? hasReachedMax,
  }) {
    return CharactersLoaded(
      characters: characters ?? this.characters,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [characters, currentPage, isLoadingMore, hasReachedMax];
}
