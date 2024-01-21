part of 'suggestion_bloc.dart';

class SuggestionState extends Equatable {
  const SuggestionState({
    required this.status,
    required this.form,
    required this.failure,
  });

  final SuggestionStatus status;
  final SuggestionFormEntity form;
  final Failure failure;

  factory SuggestionState.initial() => SuggestionState(
        form: SuggestionFormEntity(),
        status: SuggestionStatus.initial,
        failure: NoneFailure(),
      );

  SuggestionState copyWith({
    SuggestionStatus? status,
    SuggestionFormEntity? form,
    Failure? failure,
  }) {
    return SuggestionState(
      status: status ?? this.status,
      form: form ?? this.form,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object> get props => [status, form, failure];
}

enum SuggestionStatus {
  initial,
  loading,
  success,
  failure,
}
