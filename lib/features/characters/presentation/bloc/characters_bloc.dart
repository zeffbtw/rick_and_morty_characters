import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters/core/shared/domain/entities/character_entity.dart';
import 'package:rick_and_morty_characters/features/characters/domain/entities/characters_entity.dart';
import 'package:rick_and_morty_characters/features/characters/domain/usecases/get_characters_usecase.dart';

part 'characters_event.dart';
part 'characters_state.dart';

final class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharactersUseCase _getCharactersUseCase;

  CharactersBloc({required GetCharactersUseCase getCharactersUseCase})
    : _getCharactersUseCase = getCharactersUseCase,
      super(CharactersInitial()) {
    on<CharactersLoadRequest>(_charactersLoad);
    on<CharactersLoadMoreRequest>(_charactersLoadMore);
    on<CharactersFavoriteTap>(_favoriteTap);
  }

  FutureOr<void> _charactersLoad(
    CharactersLoadRequest event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersLoading());
    final CharactersEntity characters = await _getCharactersUseCase(1);
    emit(
      CharactersLoaded(
        characters: characters.results,
        currentPage: 1,
        isLoadingMore: false,
        hasReachedMax: characters.results.isEmpty,
      ),
    );
  }

  FutureOr<void> _charactersLoadMore(
    CharactersLoadMoreRequest event,
    Emitter<CharactersState> emit,
  ) async {
    final currentState = state;

    if (currentState is! CharactersLoaded) return;
    if (currentState.hasReachedMax) return;
    if (currentState.isLoadingMore) return;

    emit(currentState.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentState.currentPage + 1;
      final result = await _getCharactersUseCase(nextPage);

      emit(
        currentState.copyWith(
          characters: [...currentState.characters, ...result.results],
          currentPage: nextPage,
          isLoadingMore: false,
          hasReachedMax: result.info.next == null,
        ),
      );
    } catch (_) {
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }

  FutureOr<void> _favoriteTap(
    CharactersFavoriteTap event,
    Emitter<CharactersState> emit,
  ) {}
}
