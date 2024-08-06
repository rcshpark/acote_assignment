part of 'user_vm.dart';

abstract class RepoFetchState {
  const RepoFetchState();
}

class RepoFetchInitial extends RepoFetchState {
  const RepoFetchInitial();
}

class RepoFetchLoading extends RepoFetchState {
  const RepoFetchLoading();
}

class RepoFetchSuccess extends RepoFetchState {
  final List<RepoModel> repos;

  const RepoFetchSuccess({required this.repos});
}

class RepoFetchError extends RepoFetchState {
  final String message;

  const RepoFetchError(this.message);
}
