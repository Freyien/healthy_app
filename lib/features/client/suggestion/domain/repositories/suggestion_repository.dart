import 'package:healthy_app/core/domain/entities/response.dart';

abstract class SuggestionRepository {
  Future<Response<void>> addSuggestion(String suggestion);
}
