import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters/core/shared/domain/entities/character_entity.dart';
import 'package:rick_and_morty_characters/core/usecases/usecase.dart';
import 'package:rick_and_morty_characters/features/favorites/domain/usecases/get_favorites_use_case.dart';
import 'package:rick_and_morty_characters/features/favorites/domain/usecases/toggle_favorite_use_case.dart';
import 'package:rick_and_morty_characters/features/favorites/presentation/bloc/favorites_sort_type.dart';

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
    on<FavoritesSortRequest>(_favoritesSort);
  }

  FutureOr<void> _favoritesSort(
    FavoritesSortRequest event,
    Emitter<FavoritesState> emit,
  ) {
    final currentState = state;

    if (currentState is FavoritesLoaded) {
      emit(currentState.copyWith(sortType: event.type));
      _loadAndSortFavorites(emit);
    }
  }

  Future<void> _favoritesToggle(
    FavoritesToggleRequest event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;

    if (currentState is! FavoritesLoaded) return;

    await _toggleFsavoriteUseCase(event.character);
    _loadAndSortFavorites(emit);
  }

  Future<void> _favoritesLoad(
    FavoritesLoadRequest event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    _loadAndSortFavorites(emit);
  }

  Future<void> _loadAndSortFavorites(Emitter<FavoritesState> emit) async {
    final currentState = state;
    final List<CharacterEntity> favorites = await _getFavoritesUseCase(const NoParams());

    if (currentState is FavoritesLoaded) {
      switch (currentState.sortType) {
        case FavoritesSortType.byName:
          favorites.sort((a, b) => a.name.compareTo(b.name));
          break;
        case FavoritesSortType.byGender:
          favorites.sort((a, b) => a.gender.index.compareTo(b.gender.index));
          break;
        case FavoritesSortType.none:
      }
    }

    emit(FavoritesLoaded(favorites: favorites));
  }
}
