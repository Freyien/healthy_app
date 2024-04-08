import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/extensions/packages/document_snapshot.dart';
import 'package:healthy_app/features/client/water_plan/data/datasource/water_plan_datasource.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_consumption_entity.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_plan_entity.dart';

class WaterPlanFirebaseDatasource implements WaterPlanDatasource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseCrashlytics _crashlytics;

  WaterPlanFirebaseDatasource(this._auth, this._firestore, this._crashlytics);

  @override
  Future<WaterConsumptionEntity> addWaterConsumption(
    String waterPlanId,
    int quantity,
  ) async {
    try {
      final uid = _auth.currentUser!.uid;
      final data = {
        "createdAt": Timestamp.now(),
        "userId": uid,
        "waterPlanId": waterPlanId,
        "quantity": quantity
      };

      final document = await _firestore //
          .collection('water_consumption')
          .add(data);

      data['id'] = document.id;
      final waterConsumption = WaterConsumptionEntity.fromMap(data);

      return waterConsumption;
    } catch (e, s) {
      await _crashlytics.recordError(e, s);
      throw e;
    }
  }

  @override
  Future<void> deleteWaterConsumption(String id) async {
    try {
      await _firestore //
          .collection('water_consumption')
          .doc(id)
          .delete();
    } catch (e, s) {
      await _crashlytics.recordError(e, s);
      throw e;
    }
  }

  @override
  Future<WaterPlanEntity> getWaterPlan(DateTime date) async {
    try {
      final startOfDay = date.removeTime();
      final endOfDay = startOfDay.copyWith(
        hour: 23,
        minute: 59,
        second: 59,
      );

      // Get water plan
      final uid = _auth.currentUser!.uid;
      final snapshotWaterPlan = await _firestore
          .collection('water_plan')
          .where('userId', isEqualTo: uid)
          .where('date', isGreaterThanOrEqualTo: startOfDay)
          .where('date', isLessThanOrEqualTo: endOfDay)
          .limit(1)
          .get();

      if (snapshotWaterPlan.docs.isEmpty) return WaterPlanEntity.initial();

      final waterPlanData = snapshotWaterPlan.docs.first.dataWithId;

      // Get water consumption
      final snapshot = await _firestore
          .collection('water_consumption')
          .where('waterPlanId', isEqualTo: waterPlanData['id'])
          .where('userId', isEqualTo: uid)
          .orderBy('createdAt', descending: true)
          .get();

      final waterConsumptionList = [];
      snapshot.docs.forEach((doc) {
        final waterConsumption = doc.dataWithId;

        waterConsumptionList.add(waterConsumption);
      });

      waterPlanData['waterConsumptionList'] = waterConsumptionList;

      final waterPlan = WaterPlanEntity.fromMap(waterPlanData);

      return waterPlan;
    } catch (e, s) {
      await _crashlytics.recordError(e, s);
      throw e;
    }
  }
}
