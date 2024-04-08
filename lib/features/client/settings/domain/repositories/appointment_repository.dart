import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/features/client/settings/domain/entities/appointment_entity.dart';

abstract class AppointmentRepository {
  Stream<AppointmentEntity?> getAppointment();
  Future<Response<void>> confirmAppointment(String id);
  Future<void> closeStreams();
}
