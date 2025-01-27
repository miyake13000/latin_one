import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthAPI {
    User? getCurrentUser();
    Future<User> signin(String email, String password);
    Future<User> signup(String email, String password);
    Future<void> signout();
    Future<void> updateEmail(String newEmail);
    Future<void> updatePassword(String newPassword);
}
