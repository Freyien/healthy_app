import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:healthy_app/features/client/initial_config/data/datasource/initial_config_datasource.dart';
import 'package:healthy_app/features/client/initial_config/domain/entities/initial_config_entity.dart';

class InitialConfigFirebaseDatasource implements InitialConfigDatasource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseCrashlytics _crashlytics;

  InitialConfigFirebaseDatasource(
    this._auth,
    this._firestore,
    this._crashlytics,
  );

  @override
  Future<InitialConfigEntity?> getInitialConfig() async {
    try {
      final uid = _auth.currentUser!.uid;
      final snapshot = await _firestore //
          .collection('client_config')
          .doc(uid)
          .get();

      if (!snapshot.exists) return null;

      final data = snapshot.data()!;
      final initialConfig = InitialConfigEntity.fromMap(data);

      return initialConfig;
    } catch (e, s) {
      await _crashlytics.recordError(e, s);
      throw e;
    }
  }

  @override
  Future<Map<String, dynamic>> addInitialConfig() {
    throw UnimplementedError();
  }
}
