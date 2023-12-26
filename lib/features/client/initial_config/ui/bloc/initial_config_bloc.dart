import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/features/client/initial_config/domain/entities/initial_config_entity.dart';
import 'package:healthy_app/features/client/initial_config/domain/repositories/initial_config_repository.dart';

part 'initial_config_event.dart';
part 'initial_config_state.dart';

class InitialConfigBloc extends Bloc<InitialConfigEvent, InitialConfigState> {
  final InitialConfigRepository _repository;

  InitialConfigBloc(this._repository) : super(InitialConfigState.initial()) {
    on<GetInitialConfigEvent>(_onGetInitialConfigEvent);
  }

  Future<void> _onGetInitialConfigEvent(
    GetInitialConfigEvent event,
    Emitter<InitialConfigState> emit,
  ) async {
    emit(state.copyWith(fetchingStatus: FetchingStatus.loading));

    final response = await _repository.getInitialConfig();

    if (response.isSuccess) {
      return emit(state.copyWith(
        initialConfig: response.data,
        fetchingStatus: FetchingStatus.success,
      ));
    }

    emit(state.copyWith(
      fetchingStatus: FetchingStatus.failure,
    ));
  }
}
