part of 'user_vm.dart';

abstract class RemoteFetchUserState {
  const RemoteFetchUserState();
}

class RemoteFetchUserInitial extends RemoteFetchUserState {
  const RemoteFetchUserInitial();
}

class RemoteFetchUserLoading extends RemoteFetchUserState {
  const RemoteFetchUserLoading();
}

class RemoteFetchUserSuccess extends RemoteFetchUserState {
  final List<UserModel> userInfo;
  final bool isLoadingMore;

  RemoteFetchUserSuccess({required this.userInfo, this.isLoadingMore = false});
}

class RemoteFetchUserError extends RemoteFetchUserState {
  final String message;

  RemoteFetchUserError(this.message);
}
