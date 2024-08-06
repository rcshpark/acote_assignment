abstract class UserUsecase<T, P> {
  Future<T> fetchUser(P since);
  Future<T> fetchUserRepo(P name);
}
