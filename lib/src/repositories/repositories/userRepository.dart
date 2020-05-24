part of repo;

class _UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<User> getMe() => _userProvider.getMe();

  Future<User> getUserInfo(int userId) => _userProvider.getUserInfo(userId);

  Future<List<SimpleUser>> getMeFriends(FriendType type,
          [int page = 1, int pageSize = 10]) =>
      _userProvider.getMeFriends(type, page, pageSize);

  Future<List<SimpleUser>> getUserFriends(int userId,
          [int page, int pageSize]) =>
      _userProvider.getUserFriends(userId, page, pageSize);

  Future<List<SimpleTour>> getUserTours(int userId) =>
      _userProvider.getUserTours(userId);

  Future<User> updateProfile(UserToPut userToPut) =>
      _userProvider.updateProfile(userToPut);
}
