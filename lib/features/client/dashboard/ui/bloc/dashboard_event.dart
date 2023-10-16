part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class ChangeIndex extends DashboardEvent {
  ChangeIndex(this.index);

  final int index;
}
