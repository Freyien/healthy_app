part of 'initial_config_bloc.dart';

sealed class InitialConfigEvent extends Equatable {
  const InitialConfigEvent();

  @override
  List<Object> get props => [];
}

class GetInitialConfigEvent extends InitialConfigEvent {}
