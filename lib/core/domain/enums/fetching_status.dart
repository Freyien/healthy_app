enum FetchingStatus { initial, loading, success, failure }

extension FetchingStatusExtensions on FetchingStatus {
  bool get isInitial => this == FetchingStatus.initial;
  bool get isLoading => this == FetchingStatus.loading;
  bool get isFailure => this == FetchingStatus.failure;
  bool get isSuccess => this == FetchingStatus.success;
  bool get isInitialOrLoading => isInitial || isLoading;
}
