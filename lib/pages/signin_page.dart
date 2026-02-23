import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends ConsumerState<SigninPage> {
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _registerNameController = TextEditingController();
  final _registerAddressController = TextEditingController();

  Future<void> _signIn() async {
    final userNotifier = ref.read(userProvider.notifier);

    try {
      await userNotifier.signin(
        _loginEmailController.text,
        _loginPasswordController.text,
      );

      if (mounted) {
        Fluttertoast.showToast(msg: "ログインしました");
        context.go('/');
      }
    } on FirebaseAuthException catch (e) {
      String message = 'エラーが発生しました';

      switch (e.code) {
        case 'user-not-found':
          message = 'アカウントが見つかりません';
          break;
        case 'wrong-password':
          message = 'パスワードが間違っています';
          break;
        case 'invalid-email':
          message = 'メールアドレスの形式が正しくありません';
          break;
      }

      if (mounted) {
        Fluttertoast.showToast(msg: message);
      }
    }
  }

  Future<void> _register() async {
    final userNotifier = ref.read(userProvider.notifier);

    try {
      // アカウントを作成
      await userNotifier.signup(
        _registerEmailController.text,
        _registerPasswordController.text,
        _registerNameController.text,
        _registerAddressController.text,
      );

      if (mounted) {
        Fluttertoast.showToast(msg: "登録しました");
        context.go('/account');
      }
    } on FirebaseAuthException catch (e) {
      String message = 'エラーが発生しました';

      switch (e.code) {
        case 'weak-password':
          message = 'パスワードが弱すぎます';
          break;
        case 'email-already-in-use':
          message = 'このメールアドレスは既に使用されています';
          break;
        case 'invalid-email':
          message = 'メールアドレスの形式が正しくありません';
          break;
      }

      if (mounted) {
        Fluttertoast.showToast(msg: message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'アカウントをお持ちの方',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _loginEmailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _loginPasswordController,
              decoration: const InputDecoration(
                labelText: 'パスワード',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _signIn,
                child: const Text('ログイン'),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'アカウントをお持ちでない方',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _registerEmailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _registerPasswordController,
              decoration: const InputDecoration(
                labelText: 'パスワード',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _registerNameController,
              decoration: const InputDecoration(
                labelText: 'お名前',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _registerAddressController,
              decoration: const InputDecoration(
                labelText: '住所',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _register,
                child: const Text('登録'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    super.dispose();
  }
}
