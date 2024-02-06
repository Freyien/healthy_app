part of 'delete_account_bloc.dart';

sealed class DeleteAccountEvent extends Equatable {
  const DeleteAccountEvent();

  @override
  List<Object> get props => [];
}

class DeleteUserAccountEvent extends DeleteAccountEvent {}
