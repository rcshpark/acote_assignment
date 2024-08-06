import 'package:acote_assignment/data/data_source/remote/user_data_source.dart';
import 'package:acote_assignment/data/dto/repo_dto.dart';
import 'package:acote_assignment/data/dto/user_dto.dart';
import 'package:acote_assignment/data/translator/translator.dart';
import 'package:acote_assignment/domain/model/data_state_model.dart';
import 'package:acote_assignment/domain/model/repo_model.dart';
import 'package:acote_assignment/domain/model/user_model.dart';
import 'package:acote_assignment/domain/respository/user_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepoImplProvider = Provider<UserRepoImpl>((ref) {
  return UserRepoImpl(ref);
});

class UserRepoImpl implements UserRepo {
  final Ref ref;
  UserRepoImpl(this.ref);

  @override
  Future<DataState<List<UserModel>>> fetchUser(int since) async {
    try {
      final response = await ref.read(userDataSource).fetchUser(since);
      List<UserDto> userDto = response.map((e) => UserDto.fromJson(e)).toList();
      return Translator().transalateUserInfo(userDto);
    } catch (error) {
      return DataState.error(Exception(), error.toString());
    }
  }

  @override
  Future<DataState<List<RepoModel>>> fetchUserRepo(String userName) async {
    try {
      final response = await ref.read(userDataSource).fetchUserRepo(userName);
      List<RepoDto> repoDto = response.map((e) => RepoDto.fromJson(e)).toList();
      return Translator().transalateRepoInfo(repoDto);
    } catch (error) {
      return DataState.error(Exception(), error.toString());
    }
  }
}
