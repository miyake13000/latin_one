import 'package:firebase_auth/firebase_auth.dart';

import '../auth_api.dart';

class FirebaseAuthAPI implements AuthAPI {
    final FirebaseAuth auth;
    FirebaseAuthAPI({required this.auth});

    @override
    User? getCurrentUser() {
        return auth.currentUser;
    }

    @override
    Future<User> signin(String email, String password) async {
        final userCredential = await auth.signInWithEmailAndPassword(
                email: email,
                password: password,
                );
        return userCredential.user!;
    }

    @override
    Future<User> signup(String email, String password) async {
        final UserCredential userCredential = await auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
        );
        return userCredential.user!;
    }

    @override
    Future<void> signout() async {
        auth.signOut();
    }

    @override
    Future<void> updateEmail(String newEmail) async {
        final User? user = auth.currentUser;
        if (user == null) {
            throw Exception('No user is currently signed in');
        }
        await user.updateEmail(newEmail);
    }

    @override
    Future<void> updatePassword(String newPassword) async {
        final User? user = auth.currentUser;
        if (user == null) {
            throw Exception('No user is currently signed in');
        }
        await user.updatePassword(newPassword);
    }
}
