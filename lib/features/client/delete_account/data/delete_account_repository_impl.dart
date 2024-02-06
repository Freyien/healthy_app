import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/delete_account/domain/repositories/delete_account_repository.dart';

class DeleteAccountRepositoryImpl implements DeleteAccountRepository {
  DeleteAccountRepositoryImpl(this._client);

  final CloudClient _client;

  @override
  Future<Response<void>> deleteUserAccount() async {
    try {
      await _client.post('deleteUserAccount');

      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
