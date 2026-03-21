import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_characters/core/network/dio_client.dart';
import 'package:rick_and_morty_characters/features/main/presentation/bloc/main_bloc.dart';
import 'package:talker/talker.dart';

final getIt = GetIt.instance;

void initDependencies() {
  getIt.registerLazySingleton<Talker>(() => Talker());
  getIt.registerLazySingleton<DioClient>(() => DioClient(talker: getIt<Talker>()));
  getIt.registerFactory<MainBloc>(() => MainBloc());
}
