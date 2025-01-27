import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../repositories/user_info_repository.dart';
import '../repositories/auth_repository.dart';
import '../providers.dart';

class UserController extends AsyncNotifier<User?> {
    @override
    Future<User?> build() async {
        final authRepository = ref.read(authRepositoryProvider);
        final userInfoRespository = ref.read(userInfoRepositoryProvider);
        final userCredentials = authRepository.getCurrentUserCredentials();
        if (userCredentials != null) {
            final userInfo = await userInfoRespository.fetchUserInfo(userCredentials.id);
            return User(crendentials: userCredentials, data: userInfo);
        } else {
            return null;
        }
    }

    Future<void> updateEmail(String newEmail) async {
        final authRepository = ref.read(authRepositoryProvider);
        await authRepository.updateEmail(newEmail);
        state = state.value!.copyWith(email: newEmail);
    }

    void updatePassword(String newPassword) {
        // Update the password
    }

    void updateName(String newName) {
        state = state.copyWith(name: newName);
    }

    void updateAddress(String newAddress) {
        state = state.copyWith(email: newAddress);
    }
}

final userControllerProvider = AsyncNotifierProvider<UserController, User>(UserController.new);
