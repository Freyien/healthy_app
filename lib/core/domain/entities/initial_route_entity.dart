import 'package:equatable/equatable.dart';

class InitialRouteEntity extends Equatable {
  final InitialRoute name;
  final Map<String, dynamic> params;

  InitialRouteEntity({
    this.name = InitialRoute.notDefined,
    this.params = const {},
  });

  bool get isValid => name != InitialRoute.notDefined;

  InitialRouteEntity copyWith({
    InitialRoute? name,
    Map<String, dynamic>? params,
  }) {
    return InitialRouteEntity(
      name: name ?? this.name,
      params: params ?? this.params,
    );
  }

  @override
  List<Object> get props => [name, params];
}

enum InitialRoute { signIn, notification, appUpdate, initialConfig, notDefined }
