import 'package:cloud_functions/cloud_functions.dart';
import 'package:healthy_app/core/data/network/cloud_client.dart';
import 'package:healthy_app/core/domain/entities/response.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/suggestion/domain/failures/suggestion_failure.dart';
import 'package:healthy_app/features/client/suggestion/domain/repositories/suggestion_repository.dart';

class SuggestionRepositoryImpl implements SuggestionRepository {
  final CloudClient _client;

  SuggestionRepositoryImpl(this._client);

  @override
  Future<Response<void>> addSuggestion(String suggestion) async {
    try {
      await _client.post(
        'addSuggestion',
        parameters: {'suggestion': suggestion},
      );

      return Response.success(null);
    } on FirebaseFunctionsException catch (e) {
      final details = e.details ?? {};
      final errorCode = details['errorCode'] ?? '';

      if (errorCode == 'limitReached')
        return Response.failed(SuggestionLimitReachedFailure());

      return Response.failed(UnexpectedFailure());
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
