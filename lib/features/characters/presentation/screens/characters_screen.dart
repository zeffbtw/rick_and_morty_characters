import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty_characters/features/characters/presentation/widgets/character_card.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.hasClients == false) return;

    final position = _scrollController.position;
    final threshold = position.maxScrollExtent * 0.8;

    if (position.pixels >= threshold) {
      context.read<CharactersBloc>().add(const CharactersLoadMoreRequest());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersBloc, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (state is CharactersLoaded) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.characters.length + (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (state.isLoadingMore && index == state.characters.length) {
                return const SizedBox(
                  height: 80,
                  child: Center(child: CircularProgressIndicator.adaptive()),
                );
              }

              final character = state.characters[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CharacterCard(
                  character: character,
                  onFavoriteTap: () {
                    context.read<CharactersBloc>().add(
                      CharactersFavoriteTap(character: character),
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
