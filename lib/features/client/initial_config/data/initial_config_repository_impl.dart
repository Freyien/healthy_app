import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/initial_config/data/datasource/initial_config_firebase_datasource.dart';
import 'package:healthy_app/features/client/initial_config/data/datasource/initial_config_server_datasource.dart';
import 'package:healthy_app/features/client/initial_config/domain/entities/initial_config_entity.dart';
import 'package:healthy_app/features/client/initial_config/domain/repositories/initial_config_repository.dart';

class InitialConfigRepositoryImpl implements InitialConfigRepository {
  final FirebaseAuth _auth;
  final InitialConfigFirebaseDatasource _firebase;
  final InitialConfigServerDatasource _server;

  InitialConfigRepositoryImpl(this._firebase, this._server, this._auth);

  @override
  Future<Response<InitialConfigEntity>> getInitialConfig() async {
    try {
      InitialConfigEntity? initialConfig = await _firebase.getInitialConfig();

      if (initialConfig == null) {
        await _server.addInitialConfig();
        initialConfig = InitialConfigEntity.initial();
      }

      return Response.success(initialConfig);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<Response<bool>> checkEmailVerified() async {
    try {
      final emailVerified = _auth.currentUser?.emailVerified ?? true;
      return Response.success(emailVerified);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
