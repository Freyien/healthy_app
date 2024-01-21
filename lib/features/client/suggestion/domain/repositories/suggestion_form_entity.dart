import 'package:formz/formz.dart';
import 'package:healthy_app/features/client/suggestion/domain/entities/suggestion_entity.dart';

class SuggestionFormEntity with FormzMixin {
  SuggestionFormEntity({
    this.suggestion = const SuggestionEntity.pure(),
  });

  final SuggestionEntity suggestion;

  SuggestionFormEntity copyWith({
    SuggestionEntity? suggestion,
  }) {
    return SuggestionFormEntity(
      suggestion: suggestion ?? this.suggestion,
    );
  }

  @override
  List<FormzInput> get inputs => [suggestion];
}
