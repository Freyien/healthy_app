part of 'initial_config_bloc.dart';

sealed class InitialConfigEvent extends Equatable {
  const InitialConfigEvent();

  @override
  List<Object> get props => [];
}

class CheckEmailVerifiedEvent extends InitialConfigEvent {}

class GetInitialConfigEvent extends InitialConfigEvent {}

class CompleteOnboardingEvent extends InitialConfigEvent {}
