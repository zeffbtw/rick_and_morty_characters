import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_characters/core/network/dio_client.dart';
import 'package:rick_and_morty_characters/core/storage/local_storage_service.dart';
import 'package:rick_and_morty_characters/features/characters/data/datasource/character_local_data_source.dart';
import 'package:rick_and_morty_characters/features/characters/data/datasource/character_remote_datasource.dart';
import 'package:rick_and_morty_characters/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rick_and_morty_characters/features/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty_characters/features/characters/domain/usecases/get_characters_usecase.dart';
import 'package:rick_and_morty_characters/features/characters/presentation/bloc/characters_bloc.dart';
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
  getIt.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSourceImpl(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<CharacterLocalDataSource>(
    () => CharacterLocalDataSourceImpl(localStorageService: getIt<LocalStorageService>()),
  );
  getIt.registerLazySingleton<CharactersRepository>(
    () => CharactersRepositoryImpl(
      characterRemoteDataSource: getIt<CharacterRemoteDataSource>(),
      characterLocalDataSource: getIt<CharacterLocalDataSource>(),
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

  await getIt.allReady();
}
