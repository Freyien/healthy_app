import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/suggestion/domain/entities/suggestion_entity.dart';
import 'package:healthy_app/features/client/suggestion/domain/repositories/suggestion_form_entity.dart';
import 'package:healthy_app/features/client/suggestion/domain/repositories/suggestion_repository.dart';

part 'suggestion_event.dart';
part 'suggestion_state.dart';

class SuggestionBloc extends Bloc<SuggestionEvent, SuggestionState> {
  final SuggestionRepository _repository;

  SuggestionBloc(this._repository) : super(SuggestionState.initial()) {
    on<ChangeSuggestionEvent>(_onChangeSuggestionEvent);
    on<AddSuggestionEvent>(_onAddSuggestionEvent);
  }

  void _onChangeSuggestionEvent(
    ChangeSuggestionEvent event,
    Emitter<SuggestionState> emit,
  ) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          suggestion: SuggestionEntity.dirty(event.suggestion),
        ),
      ),
    );
  }

  Future<void> _onAddSuggestionEvent(
    AddSuggestionEvent event,
    Emitter<SuggestionState> emit,
  ) async {
    emit(
      state.copyWith(status: SuggestionStatus.loading),
    );

    final suggestion = state.form.suggestion.value;
    final response = await _repository.addSuggestion(suggestion);

    // Success
    if (response.isSuccess) {
      return emit(
        state.copyWith(status: SuggestionStatus.success),
      );
    }

    return emit(
      state.copyWith(
        status: SuggestionStatus.failure,
        failure: response.failure,
      ),
    );
  }
}
