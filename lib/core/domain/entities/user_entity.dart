import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/utils/enum_utils.dart';

class UserEntity extends Equatable {
  const UserEntity({
    this.uid = '',
    this.email = '',
    this.role = UserRole.client,
    this.name = '',
  });

  final String uid;
  final String email;
  final UserRole role;
  final String name;

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      uid: map['uid'],
      email: map['email'],
      role: EnumUtils.stringToEnum(
            UserRole.values,
            map['role'],
          ) ??
          UserRole.unknow,
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'email': email,
        'role': role.name,
      };

  @override
  List<Object> get props => [uid, email, role];
}

enum UserRole {
  client,
  business,
  unknow,
}
