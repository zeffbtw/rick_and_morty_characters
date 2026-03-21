import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainInitial(0)) {
    on<MainTabChanged>(_onTabChanged);
  }

  void _onTabChanged(MainTabChanged event, Emitter<MainState> emit) {
    emit(MainInitial(event.index));
  }
}
