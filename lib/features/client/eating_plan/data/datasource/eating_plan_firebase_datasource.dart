import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/features/client/eating_plan/data/datasource/eating_plan_datasource.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/eating_plan_entity.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/food_block_entity.dart';

class EatingPlanFirebaseDatasource implements EatingPlanDatasource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  EatingPlanFirebaseDatasource(this._auth, this._firestore);

  @override
  Future<EatingPlanEntity> getEatingPlan(DateTime date) async {
    // Get checked food
    final uid = _auth.currentUser!.uid;
    final snapshotChecked = await _firestore
        .collection('eating_plan_checked')
        .where('userId', isEqualTo: uid)
        .where('date', isEqualTo: date.removeTime())
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (snapshotChecked.docs.isEmpty) return EatingPlanEntity.initial();

    final foodChecked = snapshotChecked.docs.first.data();
    foodChecked['id'] = snapshotChecked.docs.first.id;
    final eatingPlanId = foodChecked['eatingPlanId'];

    // Get eating plan
    final snapshot = await _firestore //
        .collection('eating_plan')
        .doc(eatingPlanId)
        .get();

    final eatingPlanData = snapshot.data()!;
    eatingPlanData['id'] = snapshot.id;
    eatingPlanData['foodChecked'] = foodChecked;

    final eatingPlan = EatingPlanEntity.fromMap(eatingPlanData);
    return eatingPlan;
  }

  @override
  Future<void> checkFoodOption(
    String foodCheckedId,
    FoodBlockEntity foodBlock,
    bool checked,
  ) async {
    throw UnimplementedError();
  }
}
