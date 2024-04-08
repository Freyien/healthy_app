import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/core/extensions/packages/document_snapshot.dart';
import 'package:healthy_app/features/client/settings/domain/entities/appointment_entity.dart';
import 'package:healthy_app/features/client/settings/domain/repositories/appointment_repository.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final CloudClient _server;

  AppointmentRepositoryImpl(this._auth, this._firestore, this._server);

  late StreamController<AppointmentEntity> streamController;
  late StreamSubscription streamSub;

  @override
  Stream<AppointmentEntity?> getAppointment() {
    streamController = StreamController<AppointmentEntity>();

    final uid = _auth.currentUser!.uid;
    final snapshot = _firestore
        .collection('appointments')
        .where('userId', isEqualTo: uid)
        .where('startTime', isGreaterThan: DateTime.now())
        .orderBy('startTime', descending: true)
        .limit(1)
        .snapshots();

    streamSub = snapshot.listen((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        final appointment = AppointmentEntity.initial();
        streamController.add(appointment);
        return;
      }

      final data = querySnapshot.docs.first.dataWithId;
      final appointment = AppointmentEntity.fromMap(data);

      streamController.add(appointment);
    });

    return streamController.stream;
  }

  @override
  Future<Response<void>> confirmAppointment(String id) async {
    try {
      final params = {'id': id};
      await _server.post('confirmAppointment', parameters: params);

      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<void> closeStreams() async {
    streamSub.cancel();
    await streamController.close();
  }
}
