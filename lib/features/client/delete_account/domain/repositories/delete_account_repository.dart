import 'package:healthy_app/core/domain/entities/response.dart';

abstract class DeleteAccountRepository {
  Future<Response<void>> deleteUserAccount();
}
