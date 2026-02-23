import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../models/user.dart';

class UserController extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    final authAPI = ref.watch(authAPIProvider);
    final userAPI = ref.watch(userAPIProvider);
    final fireauthUser =  authAPI.getCurrentUser();
    final uid = fireauthUser?.uid;
    return await userAPI.fetchUser(uid!);
  }

  Future<void> signup(String email, String password, String name, String address) async {
    final authAPI = ref.watch(authAPIProvider);
    final userAPI = ref.watch(userAPIProvider);
    final fireauthUser = await authAPI.signup(email, password);
    final newUser = User(name: name, email: fireauthUser.email!, address: address);
    userAPI.saveUser(newUser);
    ref.invalidateSelf();
  }

  Future<void> signin(String email, String password) async {
    final authAPI = ref.watch(authAPIProvider);
    authAPI.signin(email, password);
    ref.invalidateSelf();
  }

  Future<void> signout() async {
    final authAPI = ref.watch(authAPIProvider);
    await authAPI.signout();
    state = const AsyncData(null);
  }

  Future<void> updateEmail(String newEmail) async {
    final authAPI = ref.watch(authAPIProvider);
    final userAPI = ref.watch(userAPIProvider);
    await authAPI.updateEmail(newEmail);
    final currentUser = state.when(
      data: (user) => user,
      error: throw Exception("User is not signed in"),
      loading: throw Exception("User is not signed in"),
    );
    final newUser = currentUser!.copyWith(email: newEmail);
    userAPI.saveUser(newUser);
  }

  Future<void> updatePassword(String newPassword) async {
    final authAPI = ref.watch(authAPIProvider);
    authAPI.updatePassword(newPassword);
  }

  Future<void> updateName(String newName) async {
    final userAPI = ref.watch(userAPIProvider);
    final currentUser = state.when(
      data: (user) => user,
      error: throw Exception("User is not signed in"),
      loading: throw Exception("User is not signed in"),
    );
    final newUser = currentUser!.copyWith(name: newName);
    userAPI.saveUser(newUser);
  }

  Future<void> updateAddress(String newAddress) async {
    final userAPI = ref.watch(userAPIProvider);
    final currentUser = state.when(
      data: (user) => user,
      error: throw Exception("User is not signed in"),
      loading: throw Exception("User is not signed in"),
    );
    final newUser = currentUser!.copyWith(address: newAddress);
    userAPI.saveUser(newUser);
  }
}
