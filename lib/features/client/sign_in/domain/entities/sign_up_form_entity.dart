import 'package:formz/formz.dart';
import 'package:healthy_app/features/client/sign_in/domain/entities/entities.dart';

class SignInFormEntity with FormzMixin {
  SignInFormEntity({
    this.email = const EmailEntity.pure(),
    this.password = const PasswordEntity.pure(),
    this.showPassword = false,
  });

  final EmailEntity email;
  final PasswordEntity password;
  final bool showPassword;

  SignInFormEntity copyWith({
    EmailEntity? email,
    PasswordEntity? password,
    bool? showPassword,
  }) {
    return SignInFormEntity(
      email: email ?? this.email,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
    );
  }

  @override
  List<FormzInput> get inputs => [email, password];
}
