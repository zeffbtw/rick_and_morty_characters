part of 'main_bloc.dart';

sealed class MainState extends Equatable {
  final int tabIndex;

  const MainState(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}

final class MainInitial extends MainState {
  const MainInitial(super.tabIndex);
}
