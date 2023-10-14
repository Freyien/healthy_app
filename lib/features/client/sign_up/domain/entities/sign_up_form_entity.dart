import 'package:formz/formz.dart';
import 'package:healthy_app/features/client/sign_up/domain/entities/entities.dart';

class SignUpFormEntity with FormzMixin {
  SignUpFormEntity({
    this.email = const EmailEntity.pure(),
    this.password = const PasswordEntity.pure(),
    this.showPassword = false,
  });

  final EmailEntity email;
  final PasswordEntity password;
  final bool showPassword;

  SignUpFormEntity copyWith({
    EmailEntity? email,
    PasswordEntity? password,
    bool? showPassword,
  }) {
    return SignUpFormEntity(
      email: email ?? this.email,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
    );
  }

  @override
  List<FormzInput> get inputs => [email, password];
}
