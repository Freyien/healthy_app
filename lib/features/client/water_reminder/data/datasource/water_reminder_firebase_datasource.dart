import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:healthy_app/features/client/water_reminder/data/datasource/water_reminder_datasource.dart';
import 'package:healthy_app/features/client/water_reminder/domain/entities/water_reminder_entity.dart';

class WaterReminderFirebaseDatasource implements WaterReminderDatasource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseCrashlytics _crashlytics;

  WaterReminderFirebaseDatasource(
    this._auth,
    this._firestore,
    this._crashlytics,
  );

  @override
  Future<WaterReminderEntity> getWaterReminder() async {
    try {
      final uid = _auth.currentUser!.uid;
      final snapshot = await _firestore //
          .collection('water_reminder')
          .doc(uid)
          .get();

      if (!snapshot.exists) return WaterReminderEntity.initial();

      final waterReminderData = snapshot.data()!;

      final waterReminder = WaterReminderEntity.fromMap(waterReminderData);
      return waterReminder;
    } catch (e, s) {
      await _crashlytics.recordError(e, s);
      throw e;
    }
  }

  @override
  Future<void> saveWaterReminder(WaterReminderEntity waterReminder) {
    throw UnimplementedError();
  }
}
