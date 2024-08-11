import 'package:acote_assignment/data/const/mock_data.dart';

class MockDataSource {
  Future<List> fetchUser(int since) async {
    return fetchUserResult;
  }

  Future<List> fetchUserRepo(String userName) async {
    return fetchRepoResult;
  }
}
