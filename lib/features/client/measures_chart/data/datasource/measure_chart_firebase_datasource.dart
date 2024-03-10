import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:healthy_app/features/client/measures_chart/data/datasource/measure_chart_datasource.dart';
import 'package:healthy_app/features/client/measures_chart/domain/entities/measure_consultation_entity.dart';

class MeasureChartFirebaseDatasource implements MeasureChartDatasource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseCrashlytics _crashlytics;

  MeasureChartFirebaseDatasource(
      this._auth, this._firestore, this._crashlytics);

  @override
  Future<List<MeasureConsultationEntity>> getMeasureConsultation() async {
    try {
      final uid = _auth.currentUser!.uid;
      final snapshot = await _firestore
          .collection('measure_consultation')
          .where('userId', isEqualTo: uid)
          .orderBy('createdAt', descending: true)
          .limit(6)
          .get();

      final measureConsultationDataList = [];
      snapshot.docs.forEach((doc) {
        final data = doc.data();
        data['id'] = doc.id;

        measureConsultationDataList.add(data);
      });

      final measureConsultationList = List<MeasureConsultationEntity>.from(
        measureConsultationDataList.map(
          (item) {
            final measureConsultation = Map<String, dynamic>.from(item);
            return MeasureConsultationEntity.fromMap(measureConsultation);
          },
        ),
      );

      return measureConsultationList;
    } catch (e, s) {
      await _crashlytics.recordError(e, s);
      throw e;
    }
  }
}
