import 'package:formz/formz.dart';

enum SuggestionValidationError { empty }

class SuggestionEntity extends FormzInput<String, SuggestionValidationError> {
  const SuggestionEntity.pure([super.value = '']) : super.pure();
  const SuggestionEntity.dirty([super.value = '']) : super.dirty();

  @override
  SuggestionValidationError? validator(String value) {
    if (value.isEmpty) {
      return SuggestionValidationError.empty;
    }

    return null;
  }
}
