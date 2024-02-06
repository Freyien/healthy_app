part of 'delete_account_bloc.dart';

class DeleteAccountState extends Equatable {
  const DeleteAccountState({
    this.status = DeletingStatus.initial,
  });

  final DeletingStatus status;

  DeleteAccountState copyWith({
    DeletingStatus? status,
  }) {
    return DeleteAccountState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
