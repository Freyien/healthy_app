import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/initial_config/domain/entities/initial_config_entity.dart';
import 'package:healthy_app/features/client/initial_config/domain/repositories/initial_config_repository.dart';

class InitialConfigRepositoryImpl implements InitialConfigRepository {
  final CloudClient _client;
  final FirebaseAuth _auth;

  InitialConfigRepositoryImpl(this._client, this._auth);

  @override
  Future<Response<InitialConfigEntity>> getInitialConfig() async {
    try {
      final result = await _client.get('getInitialConfig', useCache: false);
      final emailVerified = _auth.currentUser?.emailVerified ?? true;

      final client = InitialConfigEntity.fromMap(result).copyWith(
        emailVerified: emailVerified,
      );

      return Response.success(client);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
