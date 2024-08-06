import 'package:acote_assignment/core/user_usecase.dart';
import 'package:acote_assignment/data/repository/user_repo_impl.dart';
import 'package:acote_assignment/domain/model/data_state_model.dart';
import 'package:acote_assignment/domain/model/user_model.dart';
import 'package:acote_assignment/domain/respository/user_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userUsecaseImplProvider = Provider<UserUsecaseImpl>((ref) {
  final userRepository = ref.watch(userRepoImplProvider);
  return UserUsecaseImpl(userRepository);
});

class UserUsecaseImpl implements UserUsecase {
  final UserRepo _userRepository;

  UserUsecaseImpl(this._userRepository);

  @override
  Future<DataState<List<UserModel>>> fetchUser(dynamic since) {
    return _userRepository.fetchUser(since);
  }

  @override
  Future fetchUserRepo(name) {
    // TODO: implement fetchUserRepo
    throw UnimplementedError();
  }
}
