import '../models/user.dart';

abstract class UserAPI {
  Future<void> saveUser(User user);
  Future<User> fetchUser(String uid);
}
