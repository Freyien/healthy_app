import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/features/client/initial_config/domain/entities/initial_config_entity.dart';
import 'package:healthy_app/features/client/initial_config/domain/repositories/initial_config_repository.dart';

part 'initial_config_event.dart';
part 'initial_config_state.dart';

class InitialConfigBloc extends Bloc<InitialConfigEvent, InitialConfigState> {
  final InitialConfigRepository _repository;

  InitialConfigBloc(this._repository) : super(InitialConfigState.initial()) {
    on<CheckEmailVerifiedEvent>(_onCheckEmailVerifiedEvent);
    on<GetInitialConfigEvent>(_onGetInitialConfigEvent);
    on<CompleteOnboardingEvent>(_onCompleteOnboardingEvent);
  }

  Future<void> _onCheckEmailVerifiedEvent(
    CheckEmailVerifiedEvent event,
    Emitter<InitialConfigState> emit,
  ) async {
    emit(state.copyWith(emailVerifyStatus: FetchingStatus.loading));

    final response = await _repository.checkEmailVerified();

    return emit(state.copyWith(
      emailVerified: response.data,
      emailVerifyStatus: FetchingStatus.success,
    ));
  }

  Future<void> _onGetInitialConfigEvent(
    GetInitialConfigEvent event,
    Emitter<InitialConfigState> emit,
  ) async {
    emit(state.copyWith(initialConfigStatus: FetchingStatus.loading));

    final response = await _repository.getInitialConfig();

    if (response.isSuccess) {
      return emit(state.copyWith(
        initialConfig: response.data,
        initialConfigStatus: FetchingStatus.success,
      ));
    }

    emit(state.copyWith(
      initialConfigStatus: FetchingStatus.failure,
    ));
  }

  Future<void> _onCompleteOnboardingEvent(
    CompleteOnboardingEvent event,
    Emitter<InitialConfigState> emit,
  ) async {
    emit(state.copyWith(finishOnboardingStatus: SavingStatus.loading));

    final response = await _repository.completeOnboarding();

    if (response.isSuccess) {
      return emit(state.copyWith(
        finishOnboardingStatus: SavingStatus.success,
      ));
    }

    emit(state.copyWith(
      finishOnboardingStatus: SavingStatus.failure,
    ));
  }
}
