import 'package:acote_assignment/domain/model/data_state_model.dart';
import 'package:acote_assignment/domain/model/repo_model.dart';
import 'package:acote_assignment/domain/model/user_model.dart';

abstract class UserRepo {
  Future<DataState<List<UserModel>>> fetchUser(int since);
  Future<DataState<List<RepoModel>>> fetchUserRepo(String userName);
}
