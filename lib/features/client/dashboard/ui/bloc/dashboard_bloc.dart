import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState()) {
    on<ChangeIndex>(_onChangeIndex);
  }

  void _onChangeIndex(
    ChangeIndex event,
    Emitter<DashboardState> emit,
  ) async {
    emit(
      state.copyWith(
        status: DashboardStatus.changedIndex,
        selectedIndex: event.index,
      ),
    );
  }
}
