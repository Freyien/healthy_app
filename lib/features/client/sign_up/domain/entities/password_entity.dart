import 'package:formz/formz.dart';

enum PasswordError { empty }

class PasswordEntity extends FormzInput<String, PasswordError> {
  const PasswordEntity.pure([super.value = '']) : super.pure();
  const PasswordEntity.dirty([super.value = '']) : super.dirty();

  @override
  PasswordError? validator(String value) {
    if (value.isEmpty) {
      return PasswordError.empty;
    }

    return null;
  }
}
