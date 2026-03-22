import 'package:flutter/material.dart';
import 'package:rick_and_morty_characters/features/characters/presentation/screens/characters_screen.dart';
import 'package:rick_and_morty_characters/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters/features/main/presentation/bloc/main_bloc.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final pages = [const CharactersScreen(), const FavoritesScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        state is MainInitial;
        return Scaffold(
          body: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 24),
            child: IndexedStack(index: state.tabIndex, children: pages),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.tabIndex,
            onTap: (index) => context.read<MainBloc>().add(MainTabChanged(index)),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Characters'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
            ],
          ),
        );
      },
    );
  }
}
