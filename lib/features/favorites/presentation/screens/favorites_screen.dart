import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters/core/shared/domain/entities/character_entity.dart';
import 'package:rick_and_morty_characters/core/shared/widgets/character_card.dart';
import 'package:rick_and_morty_characters/features/favorites/presentation/bloc/favorites_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (state is FavoritesLoaded) {
          return ListView.builder(
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final character = state.favorites[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: BlocSelector<FavoritesBloc, FavoritesState, List<CharacterEntity>>(
                  selector: (state) {
                    if (state is FavoritesLoaded) {
                      return state.favorites;
                    }
                    return [];
                  },
                  builder: (context, favorites) {
                    final isFavorite = favorites.contains(character);

                    return CharacterCard(
                      character: character,
                      isFavorite: isFavorite,
                      onFavoriteTap: () {
                        context.read<FavoritesBloc>().add(
                          FavoritesToggleRequest(character),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
