import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters/core/di/injection.dart';
import 'package:rick_and_morty_characters/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty_characters/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:rick_and_morty_characters/features/main/presentation/bloc/main_bloc.dart';
import 'package:rick_and_morty_characters/features/main/presentation/screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(create: (_) => getIt<MainBloc>()),
        BlocProvider<CharactersBloc>(create: (_) => getIt<CharactersBloc>()),
        BlocProvider<FavoritesBloc>(create: (_) => getIt<FavoritesBloc>()),
      ],
      child: MaterialApp(home: MainScreen()),
    );
  }
}
