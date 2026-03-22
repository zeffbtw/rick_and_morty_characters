import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_characters/core/network/dio_client.dart';
import 'package:rick_and_morty_characters/core/storage/local_storage_service.dart';
import 'package:rick_and_morty_characters/features/characters/data/datasource/characters_local_data_source.dart';
import 'package:rick_and_morty_characters/features/characters/data/datasource/characters_remote_datasource.dart';
import 'package:rick_and_morty_characters/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rick_and_morty_characters/features/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty_characters/features/characters/domain/usecases/get_characters_usecase.dart';
import 'package:rick_and_morty_characters/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty_characters/features/favorites/data/datasource/favorites_local_data_source.dart';
import 'package:rick_and_morty_characters/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:rick_and_morty_characters/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:rick_and_morty_characters/features/favorites/domain/usecases/get_favorites_use_case.dart';
import 'package:rick_and_morty_characters/features/favorites/domain/usecases/toggle_favorite_use_case.dart';
import 'package:rick_and_morty_characters/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:rick_and_morty_characters/features/main/presentation/bloc/main_bloc.dart';
import 'package:talker/talker.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  getIt.registerLazySingleton<Talker>(
    () => Talker(
      settings: TalkerSettings(useConsoleLogs: true),
      logger: TalkerLogger(settings: TalkerLoggerSettings(enableColors: false)),
    ),
  );
  getIt.registerLazySingleton<DioClient>(() => DioClient(talker: getIt<Talker>()));
  getIt.registerSingletonAsync<LocalStorageService>(
    () async => await LocalStorageServiceImpl().init(),
  );

  // Main
  getIt.registerFactory<MainBloc>(() => MainBloc());

  // Characters
  getIt.registerLazySingleton<CharactersRemoteDataSource>(
    () => CharactersRemoteDataSourceImpl(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<CharactersLocalDataSource>(
    () =>
        CharactersLocalDataSourceImpl(localStorageService: getIt<LocalStorageService>()),
  );
  getIt.registerLazySingleton<CharactersRepository>(
    () => CharactersRepositoryImpl(
      characterRemoteDataSource: getIt<CharactersRemoteDataSource>(),
      characterLocalDataSource: getIt<CharactersLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<GetCharactersUseCase>(
    () => GetCharactersUseCase(getIt<CharactersRepository>()),
  );
  getIt.registerFactory<CharactersBloc>(
    () =>
        CharactersBloc(getCharactersUseCase: getIt<GetCharactersUseCase>())
          ..add(const CharactersLoadRequest()),
  );

  // Favorites
  getIt.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(localStorageService: getIt<LocalStorageService>()),
  );
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(
      favoritesLocalDataSource: getIt<FavoritesLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<GetFavoritesUseCase>(
    () => GetFavoritesUseCase(getIt<FavoritesRepository>()),
  );
  getIt.registerLazySingleton<ToggleFavoriteUseCase>(
    () => ToggleFavoriteUseCase(getIt<FavoritesRepository>()),
  );
  getIt.registerFactory<FavoritesBloc>(
    () => FavoritesBloc(
      getFavoritesUseCase: getIt<GetFavoritesUseCase>(),
      toggleFsavoriteUseCase: getIt<ToggleFavoriteUseCase>(),
    )..add(FavoritesLoadRequest()),
  );

  await getIt.allReady();
}
