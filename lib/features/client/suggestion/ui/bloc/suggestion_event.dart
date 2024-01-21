part of 'suggestion_bloc.dart';

sealed class SuggestionEvent extends Equatable {
  const SuggestionEvent();

  @override
  List<Object> get props => [];
}

class ChangeSuggestionEvent extends SuggestionEvent {
  final String suggestion;

  ChangeSuggestionEvent(this.suggestion);
}

class AddSuggestionEvent extends SuggestionEvent {}
