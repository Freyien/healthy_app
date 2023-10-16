part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  const DashboardState({
    this.status = DashboardStatus.initial,
    this.selectedIndex = 0,
  });

  final DashboardStatus status;
  final selectedIndex;

  DashboardState copyWith({
    DashboardStatus? status,
    int? selectedIndex,
  }) {
    return DashboardState(
      status: status ?? this.status,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object> get props => [status, selectedIndex];
}

enum DashboardStatus { initial, changedIndex }
