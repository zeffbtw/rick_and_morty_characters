import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters/core/shared/domain/entities/character_entity.dart';
import 'package:rick_and_morty_characters/core/usecases/usecase.dart';
import 'package:rick_and_morty_characters/features/favorites/domain/usecases/get_favorites_use_case.dart';
import 'package:rick_and_morty_characters/features/favorites/domain/usecases/toggle_favorite_use_case.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

final class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritesUseCase _getFavoritesUseCase;
  final ToggleFavoriteUseCase _toggleFsavoriteUseCase;

  FavoritesBloc({
    required GetFavoritesUseCase getFavoritesUseCase,
    required ToggleFavoriteUseCase toggleFsavoriteUseCase,
  }) : _getFavoritesUseCase = getFavoritesUseCase,
       _toggleFsavoriteUseCase = toggleFsavoriteUseCase,
       super(FavoritesInitial()) {
    on<FavoritesLoadRequest>(_favoritesLoad);
    on<FavoritesToggleRequest>(_favoritesToggle);
  }

  Future<void> _favoritesToggle(
    FavoritesToggleRequest event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    if (currentState is! FavoritesLoaded) return;
    await _toggleFsavoriteUseCase(event.character);
    final List<CharacterEntity> favorites = await _getFavoritesUseCase(const NoParams());
    emit(FavoritesLoaded(favorites));
  }

  Future<void> _favoritesLoad(
    FavoritesLoadRequest event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    final List<CharacterEntity> favorites = await _getFavoritesUseCase(const NoParams());
    emit(FavoritesLoaded(favorites));
  }
}
