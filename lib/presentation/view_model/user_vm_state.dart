part of 'user_vm.dart';

abstract class RemoteUserState {
  const RemoteUserState();
}

class RemoteFetchUserInitial extends RemoteUserState {
  const RemoteFetchUserInitial();
}

class RemoteFetchUserLoading extends RemoteUserState {
  const RemoteFetchUserLoading();
}

class RemoteFetchUserSuccess extends RemoteUserState {
  final List<UserModel> userInfo;
  final bool isLoadingMore;

  RemoteFetchUserSuccess({required this.userInfo, this.isLoadingMore = false});
}

class RemoteFetchUserError extends RemoteUserState {
  final String message;

  RemoteFetchUserError(this.message);
}
