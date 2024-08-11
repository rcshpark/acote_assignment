import 'package:acote_assignment/data/repository/mock_user_repo_impl.dart';
import 'package:acote_assignment/domain/usecase/user_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:acote_assignment/presentation/view_model/user_vm.dart';

void main() {
  // user vm
  late UserVm userVm;
  late MockUserRepoImpl mockUserRepository;
  late UserUsecaseImpl fetchUsersUseCase;

  // repo vm
  late RepoVm repoVm;

  setUp(() {
    mockUserRepository = MockUserRepoImpl();
    fetchUsersUseCase = UserUsecaseImpl(mockUserRepository);
    userVm = UserVm(fetchUsersUseCase);
    repoVm = RepoVm(fetchUsersUseCase);
  });

  test('사용자 조회 테스트', () async {
    await userVm.fetchUsers(isInitialLoad: true);

    expect(userVm.state, isA<RemoteFetchUserSuccess>());
  });

  test('특정 사용자의 레파지토리 조회', () async {
    await repoVm.fetchUserRepos('rcshpark');

    expect(repoVm.state, isA<RepoFetchSuccess>());
  });

  test('에러상황 테스트', () async {
    // mock data 수정 후 진행
    await repoVm.fetchUserRepos('rcshpark');
    expect(userVm.state, isA<RemoteFetchUserError>());
  });
}
