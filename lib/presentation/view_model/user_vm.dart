import 'package:acote_assignment/domain/model/repo_model.dart';
import 'package:acote_assignment/domain/model/user_model.dart';
import 'package:acote_assignment/domain/usecase/user_usecase_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'user_vm_state.dart';
part 'repo_vm_state.dart';

final userViewModel = StateNotifierProvider<UserVm, RemoteUserState>((ref) {
  final userUsecaseImpl = ref.watch(userUsecaseImplProvider);
  return UserVm(userUsecaseImpl);
});

class UserVm extends StateNotifier<RemoteUserState> {
  final UserUsecaseImpl _userUseCaseImpl;
  int _lastUserId = 0;
  bool _isLoading = false;

  UserVm(this._userUseCaseImpl) : super(const RemoteFetchUserInitial());

  Future<void> fetchUsers({bool isInitialLoad = false}) async {
    // 중복 호출 방지
    if (_isLoading) return;

    _isLoading = true;

    if (isInitialLoad) {
      state = const RemoteFetchUserLoading();
    } else if (state is RemoteFetchUserSuccess) {
      final currentState = state as RemoteFetchUserSuccess;
      state = RemoteFetchUserSuccess(
          userInfo: currentState.userInfo, isLoadingMore: true);
    }
    final response = await _userUseCaseImpl.fetchUser(_lastUserId);
    response.when(success: (data) {
      List<UserModel> currentUsers = [];
      if (state is RemoteFetchUserSuccess) {
        currentUsers = (state as RemoteFetchUserSuccess).userInfo;
      }
      if (data.isNotEmpty) {
        _lastUserId = data.last.id;
        state = RemoteFetchUserSuccess(userInfo: [...currentUsers, ...data]);
      } else {
        state = RemoteFetchUserSuccess(userInfo: []);
      }
      _isLoading = false;
    }, error: (error, message) {
      state = RemoteFetchUserError(message);
    });
  }
}

final repoViewModelProvider =
    StateNotifierProvider<RepoVm, RepoFetchState>((ref) {
  final userUsecaseImpl = ref.watch(userUsecaseImplProvider);
  return RepoVm(userUsecaseImpl);
});

class RepoVm extends StateNotifier<RepoFetchState> {
  final UserUsecaseImpl _userUseCaseImpl;

  RepoVm(this._userUseCaseImpl) : super(const RepoFetchInitial());

  Future<void> fetchUserRepos(String username) async {
    state = const RepoFetchLoading();

    final response = await _userUseCaseImpl.fetchUserRepo(username);
    response.when(success: (data) {
      state = RepoFetchSuccess(repos: data);
    }, error: (error, message) {
      state = RepoFetchError(message);
    });
  }
}
